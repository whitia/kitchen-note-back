class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.string :uuid, null: false, index: { unique: true }
      t.string :external_title, null: false
      t.string :external_url, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
