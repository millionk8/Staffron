class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :company_id
      t.integer :app_id
      t.string :type
      t.integer :status, default: 0
      t.string :name
    end

    add_index :categories, :company_id
    add_index :categories, :app_id
  end
end
