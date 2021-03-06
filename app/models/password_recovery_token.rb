require 'token'

class PasswordRecoveryToken < ActiveRecord::Base
  include Token

  belongs_to :account

  default_scope ->{ where(created_at: 1.hour.ago...Time.now) }

  def self.create_new_token(account)
    where(account: account).each do |token|
      token.disable
    end

    recovery_token = new(account: account)
    recovery_token.save!
    recovery_token
  end
end
