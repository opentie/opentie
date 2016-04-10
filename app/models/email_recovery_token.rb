class EmailRecoveryToken < RecoveryToken
  belongs_to :account

  def self.create_new_token(account, email)
    raise ActiveRecord::RecordInvalid if email.empty?

    where(account: account).each do |token|
      token.disable
    end

    recovery_token = new(account: account, substitute: email)
    recovery_token.save!
    recovery_token
  end

  def recovery_email
    substitute
  end
end
