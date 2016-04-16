class RegisterEmailService

  attr_accessor :current_account

  def initialize(current_account)
    @current_account = current_account
  end

  def execute(email)
    recovery_token =
      EmailRecoveryToken.create_new_token(current_account, email)

    account_name = "sample_name" #current_account.get_name_from_kibokan

    AccountMailer.regist_email(
      email, account_name, recovery_token.token
    ).deliver_now
  end
end
