module Accounts
  class UpdateEmailService

    attr_accessor :current_account, :recovery_token

    def initialize(current_account, recovery_token)
      @current_account = current_account
      @recovery_token = recovery_token
    end

    def execute
      new_email = recovery_token.recovery_email
      current_account.update!(email: new_email)

      recovery_token.disable
    end
 end
end
