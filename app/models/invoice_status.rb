class InvoiceStatus < ActiveRecord::Base

  # Associations
  belongs_to :invoice
	scope :visible, -> { where(active: true) }
end
