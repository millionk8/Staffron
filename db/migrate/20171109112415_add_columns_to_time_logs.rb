class AddColumnsToTimeLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :time_logs, :custom, :boolean, default: false
    add_column :time_logs, :actual_started_at, :datetime
    add_column :time_logs, :actual_stopped_at, :datetime
    remove_column :time_logs, :forced_started_at
    remove_column :time_logs, :forced_stopped_at
  end
end
