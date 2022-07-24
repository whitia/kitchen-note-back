Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/health', to: 'monitorings#health'
      get '/version', to: 'monitorings#version'
      get '/metrics', to: 'monitorings#metrics'

      resources :recipes
    end
  end
end
