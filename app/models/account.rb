class Account < ActiveRecord::Base
  class ConfirmationCodeInvaldError < StandardError; end

  has_secure_password

  validates :password             , length: { minimum: 8 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  has_many :email_recovery_tokens
  has_many :password_recovery_tokens
  has_many :roles
  has_many :delegates
  has_many :divisions, through: :roles
  has_many :groups, through: :delegates

  def update_email_with_recovery_token(token)
    recovery_token = EmailRecoveryToken.find_by!(token: token)
    update!(email: recovery_token.recovery_email)
    recovery_token.disable
  end

  def confirmed_reset_password?
    assword_recovery_tokens.empty?
  end

  def confirmed_reset_email?
    email_recovery_tokens.empty?
  end

  def confirmed_email_first_time?
    !email.nil?
  end

  private
  def validate_password?
    password.present? || password_confirmation.present?
  end
end
