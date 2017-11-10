class Company < ActiveRecord::Base

  # Associations
  has_many :departments, dependent: :destroy
  has_many :app_memberships
  has_many :apps, through: :app_memberships

end