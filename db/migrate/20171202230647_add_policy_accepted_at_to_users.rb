class AddPolicyAcceptedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :policy_accepted_at, :datetime
  end
end
