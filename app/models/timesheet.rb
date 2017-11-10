class Timesheet < ApplicationRecord

  has_paper_trail on: [:update, :destroy],
                  only: [:status]

  enum status: [:submitted, :approved, :rejected, :resubmitted, :archived]

  # Associations
  belongs_to :user

  # Validation
  validates :week, :year,
            presence: true

end