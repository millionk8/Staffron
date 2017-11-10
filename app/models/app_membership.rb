class AppMembership < ActiveRecord::Base

  # Associations
  belongs_to :app
  belongs_to :company
  belongs_to :package

end