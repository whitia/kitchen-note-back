class RemoveSubCategoryFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :sub_category, :string
  end
end
