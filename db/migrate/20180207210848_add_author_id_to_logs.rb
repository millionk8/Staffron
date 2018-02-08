class AddAuthorIdToLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :logs, :author_id, :integer
    add_index :logs, :author_id
  end
end
