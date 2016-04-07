class EmailRecoveryToken < RecoveryToken

  def self.create_new_token(account_id, email)
    raise ActiveRecord::RecordInvalid if email.empty?
    recovery_token = new(token: generate_token, account_id: account_id, substitute: email)
    recovery_token.save!
    recovery_token.token
  end

  def recovery_email
    substitute
  end
end
