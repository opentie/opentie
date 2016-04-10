class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # blocking CSRF
  before_action :check_xhr

  # authentication methods
  include AuthLogic

  unless Rails.env.development?
    rescue_from Exception,                      with: :handle_500
    rescue_from ActionController::RoutingError, with: :handle_404
    rescue_from ActiveRecord::RecordNotFound,   with: :handle_404
    rescue_from ActiveRecord::RecordInvalid,    with: :handle_400
  end

  def handle_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render json: { error: '500 Internal Server Error' }, status: 500
  end

  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render json: { error: '404 Not Found' }, status: 404
  end

  def handle_400(exception = nil)
    logger.info "Rendering 400 with exception: #{exception.message}" if exception
    render json: { error: '400 Bad Request' }, status: 400
  end

  def render_unauthorized
    logger.info "Rendering 401"
    render json: { error: '401 Unauthorized' }, status: 401
  end

  def render_redirect
    logger.info "Rendering 301"
    render json: { error: '301 Redirect' }, status: 301
  end

  def account_signed_in?
    !current_account.nil? && current_account.confirmed_email_first_time?
  end

  def account_signed_in_with_not_included_confirm?
    !current_account.nil?
  end

  def authenticate_account!
    render_unauthorized unless account_signed_in?
  end

  private

  def check_xhr
    unless Rails.env.development?
      render_unauthorized if request.xhr?.nil?
    end
  end

end
