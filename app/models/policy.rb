class Policy < ApplicationRecord

  has_paper_trail on: [:update],
                  only: [:text]

  # has_attached_file :file, keep_old_files: true

  # Callbacks
  after_update :reset_users

  # Associations
  belongs_to :company
  has_many :comments, as: :commentable
  has_many :logs, as: :loggable, dependent: :destroy

  # Validations
  # validates :file, attachment_presence: true
  # validates_attachment_content_type :file, content_type: ['application/pdf']
  validates :text, presence: true, on: [:update]

  def reset_users
    User.where(company: self.company).update_all(policy_accepted_at: nil)
  end

end