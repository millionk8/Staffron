class ModuleMembership < ActiveRecord::Base

  # Associations
  belongs_to :module
  belongs_to :company

end