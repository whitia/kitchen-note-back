class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :offset
  before_action :limit

  def offset
    @offset = params[:offset].to_i
  end

  def limit
    @limit = params[:limit].to_i
  end
end
