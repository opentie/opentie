class ApplicationController < ActionController::Base
  require 'auth'
  include AuthLogic

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class NotAuthorizedException < StandardError; end

  unless Rails.env.development?
    rescue_from Exception,                      with: :handle_500
    rescue_from ActionController::RoutingError, with: :handle_404
    rescue_from ActiveRecord::RecordNotFound,   with: :handle_404
    rescue_from NotAuthorizedException,         with: :handle_401
  end

  def handle_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render json: { error: '500 error' }, status: 500
  end

  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render json: { error: '404 error' }, status: 404
  end

  def handle_404(exception = nil)
    logger.info "Rendering 401 with exception: #{exception.message}" if exception
    render json: { error: '401 error' }, status: 401
  end

  def render_redirect
    render json: { error: '301 error' }, status: 301
  end
end
