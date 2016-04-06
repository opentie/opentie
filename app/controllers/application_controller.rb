class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def user_signed_in?
    !current_user.nil? && confirmed_code?
  end

  def user_signed_in_with_not_included_confirm?
    !current_user.nil?
  end

  def authenticate_account!(account)
    session[:account_id] = account.id
    session[:expires_at] = Time.zone.now + 180.minutes
  end

  def revoke!
    session.destroy
  end

  def confirmed_code?
    return false if current_user.nil?
    current_user.confirmed
  end

  def current_user
    unless session_available?
      session.destroy
      return nil
    end
    session[:expires_at] = Time.zone.now + 180.minutes
    Account.find_by(id: session[:account_id])
  end

  def session_available?
    return if session[:expires_at].nil?
    session[:expires_at] > Time.zone.now
  end
end
