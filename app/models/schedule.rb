class Schedule < ApplicationRecord

  # Associations
  belongs_to :user

  # Validations
  validates :day, :start_time, :work_length,
            presence: true

end