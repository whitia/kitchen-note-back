Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/health', to: 'monitorings#health'
      get '/version', to: 'monitorings#version'
      get '/metrics', to: 'monitorings#metrics'

      resources :recipes, except: [:new, :edit] do
        get '/search', to: 'recipes#search', on: :collection
      end
    end
  end
  match '*path' => 'options_request#preflight', via: :options
end
