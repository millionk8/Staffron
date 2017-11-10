class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.integer :app_id
      t.string :name
      t.string :machine_name
    end

    add_index :roles, :app_id
  end
end
