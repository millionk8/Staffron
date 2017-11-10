class App < ActiveRecord::Base

  # Associations
  has_many :packages, dependent: :destroy
  has_many :app_memberships
  has_many :companies, through: :app_memberships
  has_many :roles
  has_many :user_memberships
  has_many :users, through: :user_memberships

  # Methods
  def permission
    "can_access_#{self.machine_name}"
  end

end