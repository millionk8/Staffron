class AddFileToPolicies < ActiveRecord::Migration[5.1]
  def up
    add_attachment :policies, :file
  end

  def down
    remove_attachment :policies, :file
  end
end
