class CreatePtos < ActiveRecord::Migration[5.1]
  def change
    create_table :ptos do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :status, default: 0
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :approved_at
      t.datetime :rejected_at

      t.timestamps
    end

    add_index :ptos, :user_id
    add_index :ptos, :category_id
  end
end
