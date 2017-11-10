class CreateUserMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :user_memberships do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :app_id
      t.integer :role_id
      t.string :invitation_email
      t.string :invitation_token
      t.datetime :invitation_sent_at
      t.datetime :invitation_expires_at
      t.datetime :invitation_accepted_at
      t.json :permissions

      t.timestamps
    end

    add_index :user_memberships, [:user_id, :company_id, :app_id], unique: true, name: 'user_app_index'
    add_index :user_memberships, :role_id
    add_index :user_memberships, :invitation_token
  end
end
