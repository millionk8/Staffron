class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.integer :status, default: 0

      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end

    add_index :companies, :uuid
  end
end
