class API::V1::RecipesController < ApplicationController
  def index
    recipes = {
      recipes: [
        {
          id: 1,
          title: 'foo',
          path: SecureRandom.uuid
        },
        {
          id: 2,
          title: 'bar',
          path: SecureRandom.uuid
        }
      ],
      total: 2
    }
    render json: recipes, status: :ok
  end
end
