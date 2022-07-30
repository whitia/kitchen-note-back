class API::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :set_ingredients, only: [:show]

  def index
    recipes = Recipe.order(created_at: :desc)
    image_urls = Array.new
    recipes.each do |recipe|
      image_urls.push(recipe.image.attached? ? url_for(recipe.image) : nil)
    end

    render json: {
      status: 'SUCCESS',
      data: {
        recipes: recipes,
        image_urls: image_urls,
        total: recipes.size
      }
    }
  end

  def show
    render json: {
      status: 'SUCCESS',
      data: {
        recipe: @recipe,
        image_url: @recipe.image.attached? ? url_for(@recipe.image) : nil,
        ingredients: @ingredients
      }
    }
  end

  def create
    recipe = Recipe.new(recipe_params)
    json = if recipe.save
      ingredients = save_ingredients(recipe)
      { status: 'SUCCESS', data: { recipe: recipe, ingredients: ingredients } }
    else
      { status: 'ERROR', data: recipe.errors.full_messages }
    end
    render json: json
  end

  def update
    json =
      if @recipe.update(recipe_params)
        save_ingredients(@recipe)
        { status: 'SUCCESS', data: { recipe: @recipe, ingredients: @ingredients} }
    else
      { status: 'ERROR', data: @recipe.errors.full_messages }
    end
    render json: json
  end

  def destroy
    @recipe.destroy
    save_ingredients(@recipe)
    render json: { status: 'SUCCESS', data: { recipe: @recipe, ingredients: @ingredients } }
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title,
      :uuid,
      :external_title,
      :external_url,
    )
  end

  def set_recipe
    @recipe = Recipe.find_by(uuid: params[:id])
  end

  def set_ingredients
    @ingredients = @recipe.ingredients.pluck(:name)
  end
end
