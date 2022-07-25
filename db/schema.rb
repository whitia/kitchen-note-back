# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_24_155047) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients_recipes", id: false, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.index "\"ingredients_id\"", name: "index_ingredients_recipes_on_ingredients_id"
    t.index "\"recipes_id\"", name: "index_ingredients_recipes_on_recipes_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", null: false
    t.string "uuid", null: false
    t.string "external_title", null: false
    t.string "external_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_url"], name: "index_recipes_on_external_url", unique: true
    t.index ["uuid"], name: "index_recipes_on_uuid", unique: true
  end

end
