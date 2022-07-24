class API::V1::MonitoringsController < ApplicationController
  def health
    render json: { status: '200 OK' }, status: :ok
  end

  def version
    render json: { version: '0.0.1' }, status: :ok
  end

  def metrics
    render json: { metrics: nil }, status: :ok
  end
end
