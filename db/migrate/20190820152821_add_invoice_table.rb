class AddInvoiceTable < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice do |t|
      t.datetime :date
    	t.string :qb_number
    	t.string :client_name
      t.integer :ticket_number
      t.integer :client_id
      t.integer :user_id
      t.integer :status_id
      t.integer :category_id
      t.text :note
      t.text :admin_note

      t.timestamps
    end
  end
end
