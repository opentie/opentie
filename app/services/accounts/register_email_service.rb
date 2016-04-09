module Accounts
  class RegisterEmailService

    attr_accessor :current_account, :email

    def initialize(current_account, email)
      @current_user = current_account, @token = email
    end

    def execute
      recovery_token =
        EmailRecoveryToken.create_new_token(current_account, email)

      account_name = "sample_name" #current_account.get_name_from_kibokan

      AccountMailer.regist_email(email, account_name, token).deliver
    end
 end
end
