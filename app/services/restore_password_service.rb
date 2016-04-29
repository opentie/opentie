class RestorePasswordService

  attr_accessor :current_account

  def initialize(current_account)
    @current_account = current_account
  end

  def execute
    recovery_token = PasswordRecoveryToken.create_new_token(current_account)
    email = current_account.email

    account_name = current_account.get_entity.name

    AccountMailer.regist_email(
      email, account_name, recovery_token.token
    ).deliver_later
  end
end
