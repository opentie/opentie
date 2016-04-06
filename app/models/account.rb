class Account < ActiveRecord::Base
  class ConfirmationCodeInvaldError < StandardError; end

  has_secure_password

  validates :email, {
    presence: true,
    uniqueness: true
  }
  validates :password             , length: { minimum: 8 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  has_many :email_recovery_tokens
  has_many :password_recovery_tokens

  private
  def validate_password?
    password.present? || password_confirmation.present?
  end
end
