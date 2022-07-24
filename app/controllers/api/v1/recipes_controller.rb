class API::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    recipes = Recipe.order(created_at: :desc)
    render json: recipes.to_json
  end

  def show
    render json: recipe.to_json
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { status: 'SUCCESS', data: recipe }
    else
      render json: { status: 'ERROR', data: recipe.errors }
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: { status: 'SUCCESS', data: @recipe }
    else
      render json: { status: 'ERROR', data: @recipe.errors }
    end
  end

  def destroy
    @recipe.destroy
    render json: { status: 'SUCCESS', data: @recipe }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :path, :url)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
