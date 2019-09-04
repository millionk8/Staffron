class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer :company_id
      t.integer :author_id
      t.datetime :date
      t.integer :qb_id
      t.integer :client_id
      t.string :client_name
      t.integer :employee_id
      t.string :status
      t.integer :category_id
      t.text :note
      t.integer :ticket_number
      t.text :admin_note

      t.timestamps
    end
  end
end
