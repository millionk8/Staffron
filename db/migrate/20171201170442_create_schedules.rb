class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.integer :day
      t.time :start_time
      t.integer :work_length
      t.integer :break_length

      t.timestamps
    end

    add_index :schedules, [:user_id, :day], unique: true
  end
end
