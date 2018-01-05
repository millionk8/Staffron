class Pto < ApplicationRecord

  enum status: [:pending, :approved, :rejected]

  # Callbacks
  before_save :set_status_date, if: :status_changed?
  after_update :send_email, if: :status_changed?

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

  def send_email
    if status == 'approved'
      PtoMailer.pto_approved(self).deliver_later
    elsif status == 'rejected'
      PtoMailer.pto_rejected(self).deliver_later
    end
  end

end