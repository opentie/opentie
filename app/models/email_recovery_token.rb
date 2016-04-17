require 'token'

class EmailRecoveryToken < ActiveRecord::Base
  include Token

  belongs_to :account

  def self.create_new_token(account, email)
    raise ActiveRecord::RecordInvalid if email.empty?

    where(account: account).each do |token|
      token.disable
    end

    recovery_token = new(account: account, email: email)
    recovery_token.save!
    recovery_token
  end
end
