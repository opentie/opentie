module Accounts
  class UpdatePasswordService

    attr_accessor :current_account, :recovery_token

    def initialize(current_account, recovery_token)
      @current_account = current_account
      @recovery_token = recovery_token
    end

    def execute(password, password_confirmation)
      current_account.update!(
        password: password,
        password_confirmation: password_confirmation
      )

      recovery_token.disable
    end
 end
end
