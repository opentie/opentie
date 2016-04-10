module Accounts
  class UpdatePasswordService

    attr_accessor :current_account

    def initialize(current_account)
      @current_account = current_account
    end

    def execute(token, password, password_confirmation)
      recovery_token =
        current_account.password_recovery_tokens.find_by!(token: token)

      current_account.update!(
        password: password,
        password_confirmation: password_confirmation
      )

      recovery_token.disable
    end
 end
end
