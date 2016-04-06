class PasswordRecoveryToken < RecoveryToken

  def self.create_new_token(account_id)
    token = new(token: generate_token, account_id: account_id)
    token.save!
  end
end
