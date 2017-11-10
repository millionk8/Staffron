class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.integer :app_id
      t.string :name
      t.string :machine_name
      t.integer :max_users
      t.boolean :active, default: true
    end

    add_index :packages, :uuid
    add_index :packages, :app_id
    add_index :packages, :machine_name
  end
end
