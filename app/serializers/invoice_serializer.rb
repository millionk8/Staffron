class InvoiceSerializer < ActiveModel::Serializer
  attributes :id,
  					 :date,
             :company_id,
  					 :qb_number,
  					 :client_name,
  					 :ticket_number,
  					 :client_id,
             :user_id,
             :status_id,
             :category_id,
             :note,
             :admin_note,
             :created_at,
             :updated_at
end
