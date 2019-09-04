class Invoice < ApplicationRecord
	
  enum status: [:IP, :NSR, :ZO, :SP, :SU, :PNS, :II]

  belongs_to :company
  belongs_to :user

end
