Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/health', to: 'monitorings#health'
      get '/version', to: 'monitorings#version'
      get '/metrics', to: 'monitorings#metrics'

      resources :recipes, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
