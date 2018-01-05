class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.integer :commentable_id
      t.string :commentable_type
      t.string :label
      t.text :text

      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
