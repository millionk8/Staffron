class UserMembership < ActiveRecord::Base

  has_secure_token :invitation_token

  # Associations
  belongs_to :user, optional: true
  belongs_to :company
  belongs_to :app
  belongs_to :role

  # Validations
  validates :user_id, uniqueness: { scope: [:app_id, :company_id], message: 'already subscribed' }, if: Proc.new { |o| o.user_id.present? }

  # Methods
  def is_valid?
    self.invitation_accepted_at.present?
  end

  def accepted?
    self.invitation_accepted_at.present?
  end

  def has_valid_token?
    self.invitation_expires_at.present? && self.invitation_expires_at >= Time.current
  end

end