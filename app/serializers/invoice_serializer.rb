class InvoiceSerializer < ActiveModel::Serializer
  attributes :id,
  					 :date,
             :company_id,
  					 :qb_id,
  					 :client_name,
  					 :ticket_number,
  					 :client_id,
             :employee_id,
             :author_id,
             :status,
             :category_id,
             :note,
             :admin_note,
             :created_at,
             :updated_at
end
