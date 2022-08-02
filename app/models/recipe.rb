class Recipe < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_and_belongs_to_many :ingredients, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :uuid, presence: true, uniqueness: true
  validates :external_title, presence: true
  validates :external_url, presence: true, uniqueness: true
  validates :image, presence: true

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def save_ingredients(ingredients)
    current_ingredients = self.ingredients&.pluck(:name)
    old_ingredients = current_ingredients - ingredients
    new_ingredients = ingredients - current_ingredients

    old_ingredients.each do |name|
      self.ingredients.delete(Ingredient.find_by(name: name))
    end

    new_ingredients.each do |name|
      ingredient = Ingredient.find_or_create_by(name: name)
      self.ingredients << ingredient
    end

    Ingredient.all.each do |ingredient|
      ingredient.destroy if ingredient.recipes.count == 0
    end
  end
end
