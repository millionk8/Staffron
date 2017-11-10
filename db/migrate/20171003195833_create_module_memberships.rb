class CreateModuleMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :module_memberships do |t|
      t.integer :company_id
      t.integer :module_id
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :module_memberships, [:company_id, :module_id], unique: true, name: 'copmany_module_index'
  end
end
