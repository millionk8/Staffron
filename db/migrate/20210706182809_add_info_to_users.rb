class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :joining_date, :date
    add_column :users, :employment_type, :string
    add_column :users, :remaining_pto_days, :float, default: 0.0
    add_column :users, :remaining_sickness_days, :float, default: 0.0
  end
end