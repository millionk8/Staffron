class UserPermission < ActiveRecord::Base

  # Associations
  belongs_to :app
  belongs_to :user

end