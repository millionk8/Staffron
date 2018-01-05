class AddEditableToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :editable, :boolean, default: false
    add_column :categories, :default, :boolean, default: false
  end
end
