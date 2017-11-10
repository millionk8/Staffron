class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :status, default: 0
      t.integer :company_id

      t.timestamps
    end

    add_index :departments, :company_id
  end
end
