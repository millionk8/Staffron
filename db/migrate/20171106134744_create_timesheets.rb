class CreateTimesheets < ActiveRecord::Migration[5.1]
  def change
    create_table :timesheets do |t|
      t.integer :user_id
      t.integer :week
      t.integer :year
      t.integer :status, default: 0
      t.text :note

      t.timestamps
    end
  end
end
