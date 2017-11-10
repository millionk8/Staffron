class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id

      t.string :first_name
      t.string :last_name
      t.string :encrypted_ssn
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :title
      t.date :starting_date

      t.timestamps
    end

    add_index :profiles, :user_id
  end
end
