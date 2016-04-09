class PasswordRecoveryToken < RecoveryToken

  default_scope ->{ where(created_at: 1.hour.ago...Time.now) }

  def self.create_new_token(account)
    recovery_token = new(token: generate_token, account: account)

    account.password_recovery_tokens.each do |token|
      token.disable
    end

    recovery_token.save!
    recovery_token.token
  end
end
