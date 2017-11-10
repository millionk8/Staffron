class Category < ActiveRecord::Base

  enum status: [:active, :inactive, :deleted]

  # Associations
  belongs_to :app
  belongs_to :company

  # Validations
  validates :name,
            presence: true

  # Scopes
  scope :visible, -> { where(status: [0, 1]) }

end