class Company < ActiveRecord::Base

  # Associations
  has_many :departments, dependent: :destroy
  has_many :app_memberships
  has_many :apps, through: :app_memberships
  has_many :users
  has_many :admins, -> { where(admin: true) }, class_name: 'User'
  has_many :invoices
end