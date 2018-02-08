class Policy < ApplicationRecord

  has_paper_trail on: [:update],
                  only: [:text]

  # Callbacks
  after_update :reset_users

  # Associations
  belongs_to :company
  has_many :comments, as: :commentable
  has_many :logs, as: :loggable, dependent: :destroy

  # Validations
  validates :text, presence: true


  def reset_users
    User.where(company: self.company).update_all(policy_accepted_at: nil)
  end

end