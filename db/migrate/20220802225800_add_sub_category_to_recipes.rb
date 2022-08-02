class AddSubCategoryToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :sub_category, :string
  end
end
