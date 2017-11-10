class CreateAppMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :app_memberships do |t|
      t.integer :company_id
      t.integer :app_id
      t.integer :package_id
      t.boolean :active, default: true
      t.datetime :canceled_at

      t.timestamps
    end

    add_index :app_memberships, :company_id
    add_index :app_memberships, :app_id
    add_index :app_memberships, :package_id
  end
end
