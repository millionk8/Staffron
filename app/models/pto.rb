class Pto < ApplicationRecord

  enum status: [:pending, :approved, :rejected]

  # Callbacks
  before_save :set_status_date, if: :status_changed?
  after_update :update_remaining_timeoff_days, if: :can_update_remaining_timeoff_days?
  after_update :integrate_with_time_log, if: Proc.new { |pto| pto.approved? }
  after_update :disintegrate_with_time_log, if: Proc.new { |pto| pto.rejected? }

  # Associations
  belongs_to :user
  belongs_to :category
  has_many :comments, as: :commentable

  # Validations
  validates :starts_at, :ends_at, :category_id,
            presence: true

  private

  def set_status_date
    if status == 'approved'
      self.approved_at = Time.current
      self.rejected_at = nil
    elsif status == 'rejected'
      self.rejected_at = Time.current
      self.approved_at = nil
    end
  end

  def can_update_remaining_timeoff_days?
    approved? && 
      !category.name.downcase.include?('unpaid')
  end

  def update_remaining_timeoff_days
    pto = if category.name.downcase.include?('vacation')
      'remaining_pto_days'
    elsif category.name.downcase.include?('sickness')
      'remaining_sickness_days'
    end

    remaining_days = user.send(pto.to_sym) - requested_offdays

    user.update_attribute(pto.to_sym, remaining_days)
  end

  def requested_offdays
    days = 0.0

    (starts_at.to_date..ends_at.to_date).each do |offday|
      next if offday.on_weekend?

      if offday == starts_at.to_date
        days = days + Pto.offday(17.0, starts_at.hour)
      elsif offday == ends_at.to_date
        days = days + Pto.offday(ends_at.hour, 9.0)
      else
        days = days + 1.0  
      end
    end

    days
  end

  def self.offday(from, to)
    day = (from - to) / 8.0
    day > 0.5 ? 1.0 : 0.5
  end  

  def integrate_with_time_log
    TimeLog.create!(
      user_id: user_id, 
      category_id: category_id,
      started_at: starts_at,
      stopped_at: ends_at,
      note: comments.first&.text
    )
  end

  def disintegrate_with_time_log
    TimeLog.where(
      user_id: user_id, 
      category_id: category_id,
      started_at: starts_at,
      stopped_at: ends_at
    ).first&.destroy
  end
end