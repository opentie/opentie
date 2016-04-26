class Api::BaseController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :check_xhr

  unless Rails.env.development?
    rescue_from Exception,                      with: :handle_500
    rescue_from ActionController::RoutingError, with: :handle_404
    rescue_from ActiveRecord::RecordNotFound,   with: :handle_404
    rescue_from ActiveRecord::RecordInvalid,    with: :handle_400
    rescue_from Kibokan::NotFound,              with: :handle_404
    rescue_from Kibokan::RecordInvalid,         with: :handle_400
    rescue_from Kibokan::ServerError,           with: :handle_500
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

  def render_ok(params = {})
    logger.info "Rendering 200 OK"
    render json: params, status: 200
  end

  def render_created(params = {})
    logger.info "Rendering 201 Created"
    render json: params, status: 201
  end

  def render_paginate(rows)
    logger.info "Rendering pagination 200 OK"
    paginate json: rows, status: 200
  end

  private

  def check_xhr
    unless Rails.env.development?
      render_unauthorized if request.xhr?.nil?
    end
  end
end
