Rails.application.routes.draw do
  namespace :v1 do
    get '/health', to: 'monitorings#health'
    get '/version', to: 'monitorings#version'
    get '/metrics', to: 'monitorings#metrics'
  end
end
