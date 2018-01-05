class Timesheet < ApplicationRecord

  has_paper_trail on: [:update, :destroy],
                  only: [:status]

  enum status: [:pending, :approved, :rejected, :resubmitted, :archived]

  # Associations
  belongs_to :user
  has_many :comments, as: :commentable

  # Validation
  validates :week, :year,
            presence: true

end