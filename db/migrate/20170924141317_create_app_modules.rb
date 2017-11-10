class CreateAppModules < ActiveRecord::Migration[5.1]
  def change
    create_table :app_modules do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.integer :app_id
      t.string :name
      t.string :machine_name
      t.text :description
      t.integer :status, default: 0
    end

    add_index :app_modules, :uuid
    add_index :app_modules, :app_id
    add_index :app_modules, :machine_name
  end
end
