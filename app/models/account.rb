class Account < ActiveRecord::Base
  class ConfirmationCodeInvaldError < StandardError; end

  has_secure_password

  validates :email, {
    presence: true,
    uniqueness: true
  }
  validates :password             , length: { minimum: 8 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  after_initialize :set_confirmation_code

  def confirm_code(code)
    raise ConfirmationCodeInvaldError.new if code != self.confirmation_code
    self.update(confirmed: true)
  end

  def set_confirmation_code
    update(confirmation_code: generate_confirmation_code)
  end

  private

  def generate_confirmation_code
    4.times.map { SecureRandom.random_number(10).to_s }.join
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end
end
