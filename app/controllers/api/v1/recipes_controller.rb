class API::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    recipes = Recipe.order(created_at: :desc)
    render json: { status: 'SUCCESS', body: recipes.to_json, total: recipes.size }
  end

  def show
    render json: { status: 'SUCCESS', body: @recipe.to_json }
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { status: 'SUCCESS', body: recipe }
    else
      render json: { status: 'ERROR', body: recipe.errors }
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: { status: 'SUCCESS', body: @recipe }
    else
      render json: { status: 'ERROR', body: @recipe.errors }
    end
  end

  def destroy
    @recipe.destroy
    render json: { status: 'SUCCESS', body: @recipe }
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
end
