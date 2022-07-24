class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :uuid
      t.string :external_title
      t.string :external_url

      t.timestamps
    end
  end
end
