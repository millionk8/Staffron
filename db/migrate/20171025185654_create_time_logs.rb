class CreateTimeLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :time_logs do |t|
      t.integer :user_id
      t.integer :category_id
      t.datetime :started_at
      t.datetime :stopped_at
      t.boolean :forced_started_at, default: false
      t.boolean :forced_stopped_at, default: false
      t.text :note
      t.boolean :deleted, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :time_logs, :user_id
    add_index :time_logs, :category_id
  end
end
