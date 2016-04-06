class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def account_signed_in?
    !current_account.nil? && confirmed_password? && confirmed_email?
  end

  def account_signed_in_with_not_included_confirm?
    !current_account.nil?
  end

  def sign_in!(account)
    session[:account_id] = account.id
    session[:expires_at] = Time.zone.now + 180.minutes
    true
  end

  def revoke!
    session.destroy
  end

  def confirmed_password?
    return false if current_account.nil?
    current_account.password_recovery_tokens.empty?
  end

  def confirmed_email?
    return false if current_account.nil?
    current_account.email_recovery_tokens.empty?
  end

  def current_account
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
