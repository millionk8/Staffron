class Comment < ApplicationRecord

  # Associations
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  # Validations
  validates :text, presence: true

end