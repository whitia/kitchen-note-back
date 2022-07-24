class ApplicationController < ActionController::Base
  before_action :offset
  before_action :limit

  def offset
    @offset = params[:offset].to_i
  end

  def limit
    @limit = params[:limit].to_i
  end
end
