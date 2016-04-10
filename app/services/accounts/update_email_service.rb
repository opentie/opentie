module Accounts
  class UpdateEmailService

    attr_accessor :current_account

    def initialize(current_account)
      @current_account = current_account
    end

    def execute(token)
      recovery_token =
        current_account.email_recovery_tokens.find_by!(token: token)

      new_email = recovery_token.recovery_email
      current_account.update!(email: new_email)

      recovery_token.disable
    end
 end
end
