class Account < ActiveRecord::Base

  include Kibokan::RequestQuery

  has_secure_password

  validates :email                , uniqueness: true      , allow_blank: true
  validates :password             , length: { minimum: 8 }, if: :validate_password?
  validates :password_confirmation, presence: true        , if: :validate_password?

  has_many :email_recovery_tokens
  has_many :password_recovery_tokens

  has_many :roles, dependent: :delete_all
  has_many :divisions, through: :roles

  has_many :delegates, dependent: :delete_all
  has_many :groups, through: :delegates

  has_many :topics
  has_many :posts

  def self.create_with_kibokan(params)
    kibokan_params = params.delete(:kibokan)

    account = new(params)
    unless account.valid?
      raise ActiveRecord::RecordInvalid('password does not match')
    end

    entity = insert_entity(account.current_category, kibokan_params)

    account.kibokan_id = entity.id
    account.save
    account
  end

  def update_with_kibokan(params)
    kibokan_params = params.delete(:kibokan)
    entity = update_entity(kibokan_params)

    update(params)
    self.kibokan_id = entity.id
    save
    self
  end

  # override on Kibokan::RequestQuery
  def current_category
    'accounts'
  end

  def confirmed_reset_password?
    password_recovery_tokens.empty?
  end

  def confirmed_reset_email?
    email_recovery_tokens.empty?
  end

  def confirmed_email_first_time?
    !email.nil?
  end

  def admin?
    self.is_admin
  end

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
end
