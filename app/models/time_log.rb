class TimeLog < ActiveRecord::Base

  has_paper_trail on: [:update],
                  only: [:started_at, :stopped_at]

  # Associations
  belongs_to :user
  belongs_to :category
  has_many :logs, as: :loggable, dependent: :destroy

  # Validations
  validates :user_id, :category_id,
            presence: true

  validate :check_valid_dates
  validate :check_in_future
  validate :check_overlap, if: :new_record?

  # Methods

  def self.running(user)
    self.where(user: user, stopped_at: nil).take
  end

  private

  def check_valid_dates
    if started_at.present? && stopped_at.present? && started_at >= stopped_at
      errors.add(:started_at, "can't be after end time")
    end

    if started_at.present? && stopped_at.present? && stopped_at - started_at > 24 * 60 * 60
      errors.add(:base, 'Time log is longer than 24 hours')
    end
  end

  def check_in_future
    if started_at.present? && started_at > Time.current
      errors.add(:started_at, "can't be in the future")
    end

    if stopped_at.present? && stopped_at > Time.current
      errors.add(:stopped_at, "can't be in the future")
    end
  end

  def check_overlap
    time_logs_count = TimeLog.where('users_id = :user_id AND (started_at BETWEEN :start AND :stop) OR (stopped_at BETWEEN :start AND :stop) OR (started_at <= :start AND stopped_at >= :stop)', user_id: user.id, start: started_at, stop: stopped_at).count

    if time_logs_count > 0
      errors.add(:base, "#{time_logs_count} overlapping time logs found")
    end
  end
end