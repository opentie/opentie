class EmailRecoveryToken < RecoveryToken

  def self.create_new_token(account_id, email)
    raise ActiveRecord::RecordInvalid if email.empty?
    recovery_token = new(token: generate_token, account: account, substitute: email)

    account.email_recovery_tokens.each do |token|
      token.disable
    end

    recovery_token.save!
    recovery_token.token
  end

  def recovery_email
    substitute
  end
end
