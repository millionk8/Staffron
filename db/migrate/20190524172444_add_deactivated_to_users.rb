class AddDeactivatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :deactivated, :boolean
  end
end
