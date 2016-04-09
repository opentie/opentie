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

  def self.create_with_kibokan(params)
    account = new(
      params[:password],
      params[:password_confirmation]
    )

    # no match password
    raise ActiveRecord::RecordInvalid unless account.valid?

    email = params[:email]
    params[:email] = nil
    # sync kibokan FIXME
    kibokan_id = (0...100).to_a.sample # delete later

    account.kibokan_id = kibokan_id
    account.save
    account
  end

  def update_with_kibokan(params)
    # FIXME
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
