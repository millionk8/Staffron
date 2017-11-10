class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.integer :loggable_id
      t.string :loggable_type
      t.integer :action, default: 0
      t.string :device_name
      t.string :browser_name
      t.string :os_name
      t.string :ip_address
      t.string :user_agent
      t.boolean :mobile, default: false
      t.boolean :tablet, default: false
      t.boolean :robot, default: false

      t.timestamps
    end

    add_index :logs, :uuid
    add_index :logs, :loggable_id
    add_index :logs, :loggable_type
  end
end
