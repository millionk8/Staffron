class CreatePtoAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :pto_availabilities do |t|
      t.integer :user_id
      t.integer :author_id
      t.integer :category_id
      t.integer :year
      t.float :total, default: 0.0

      t.timestamps
    end

    add_index :pto_availabilities, :user_id
    add_index :pto_availabilities, :author_id
    add_index :pto_availabilities, :category_id
  end
end
