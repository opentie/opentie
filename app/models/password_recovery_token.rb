class PasswordRecoveryToken < RecoveryToken

  default_scope ->{ where(created_at: 1.hour.ago...Time.now) }

  def self.create_new_token(account_id)
    recovery_token = new(token: generate_token, account_id: account_id)
    recovery_token.save!
    recovery_token.token
  end
end
