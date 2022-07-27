class OptionsRequestController < ApplicationController
  ACCESS_CONTROL_ALLOW_METHODS = %w[GET POST PUT PATCH DELETE OPTIONS].freeze
  ACCESS_CONTROL_ALLOW_HEADERS = %w[Accept Origin Content-Type Authorization].freeze
  ACCESS_CONTROL_MAX_AGE = 86_400

  protect_from_forgery except: :preflight

  def preflight
    response.headers['Access-Control-Max-Age'] = ACCESS_CONTROL_MAX_AGE
    response.headers['Access-Control-Allow-Headers'] = ACCESS_CONTROL_ALLOW_HEADERS.join(',')
    response.headers['Access-Control-Allow-Methods'] = ACCESS_CONTROL_ALLOW_METHODS.join(',')
    response.headers['Access-Control-Allow-Origin'] = '*'
    head :ok
  end
end
