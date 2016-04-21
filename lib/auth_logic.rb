module AuthLogic
  extend ActiveSupport::Concern

  def sign_in!(account)
    session[:account_id] = account.id
    update_session_period
    true
  end

  def sign_out!
    session.destroy
    true
  end

  def current_account
    unless session_available?
      session.destroy
      return nil
    end
    update_session_period
    Account.find_by(id: session[:account_id])
  end

  private

  def session_available?
    return false if session[:expires_at].nil?
    session[:expires_at] > Time.zone.now
  end

  def update_session_period
    session[:expires_at] = Time.zone.now + 180.minutes
  end
end
