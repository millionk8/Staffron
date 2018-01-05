class CreatePolicies < ActiveRecord::Migration[5.1]
  def change
    create_table :policies do |t|
      t.integer :company_id
      t.text :text

      t.timestamps
    end

    add_index :policies, :company_id
  end
end
