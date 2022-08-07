class API::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :set_ingredients, only: [:show]

  def index
    recipes = Recipe.order(created_at: :desc)
    image_urls = recipes.map { |recipe| recipe.image.attached? ? url_for(recipe.image) : nil }
    categories = Recipe.distinct.pluck(:category).sort
    ingredients = Ingredient.distinct.pluck(:name).sort

    render json: {
      status: 'SUCCESS',
      data: {
        recipes: recipes,
        image_urls: image_urls,
        categories: categories,
        ingredients: ingredients,
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
    json =
      if recipe.save
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

  def search
    type = params[:type]
    keyword = URI.decode(params[:keyword])

    recipes =
      case type
      when 'category' then
        Recipe.where(category: keyword).order(created_at: :desc)
      when 'ingredient' then
        Ingredient.find_by(name: keyword).recipes.order(created_at: :desc)
      end

    image_urls = recipes.map { |recipe| recipe.image.attached? ? url_for(recipe.image) : nil }

    render json: {
      status: 'SUCCESS',
      data: {
        recipes: recipes,
        image_urls: image_urls,
        total: recipes.size
      }
    }
  end

  private

  def recipe_params
    params.permit(
      :title,
      :uuid,
      :category,
      :external_title,
      :external_url,
      :image,
    )
  end

  def set_recipe
    @recipe = Recipe.find_by(uuid: params[:id])
  end

  def set_ingredients
    @ingredients = @recipe.ingredients.pluck(:name)
  end

  def save_ingredients(recipe)
    unless params[:ingredients].nil?
      ingredients = params[:ingredients].split(',')
      recipe.save_ingredients(ingredients)
      ingredients
    end
  end
end
