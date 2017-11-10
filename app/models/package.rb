class Package < ActiveRecord::Base

  # Associations
  belongs_to :app
  has_many :app_memberships
  has_many :companies, through: :app_memberships

end