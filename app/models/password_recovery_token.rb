class PasswordRecoveryToken < RecoveryToken

  default_scope ->{ where(created_at: 1.hour.ago...Time.now) }

  def self.create_new_token(account)
    where(account: account).each do |token|
      token.disable
    end

    recovery_token = new(token: generate_token, account: account)
    recovery_token.save!
    recovery_token
  end
end
