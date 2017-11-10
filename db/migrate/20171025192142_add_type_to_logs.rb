class AddTypeToLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :logs, :type, :string
  end
end
