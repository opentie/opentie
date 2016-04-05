class Account < ActiveRecord::Base
  has_secure_password

  validates :email, {
    presence: true,
    uniqueness: true
  }
  validates :password             , length: { minimum: 8 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
end
