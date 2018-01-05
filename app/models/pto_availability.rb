class PtoAvailability < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  # Validation
  validates :year, :total,
            presence: true

end