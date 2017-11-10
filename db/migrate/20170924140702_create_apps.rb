class CreateApps < ActiveRecord::Migration[5.1]
  def change
    create_table :apps do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.integer :status, default: 0
      t.string :version
      t.string :name
      t.string :machine_name
    end

    add_index :apps, :uuid
    add_index :apps, :machine_name
  end
end
