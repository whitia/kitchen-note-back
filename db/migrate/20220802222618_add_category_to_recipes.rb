class AddCategoryToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :category, :string, null: false, default: ''
  end
end
