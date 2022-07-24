class CreateRecipesIngredientsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :recipes, :ingredients do |t|
      t.index :recipes_id
      t.index :ingredients_id
    end
  end
end
