module Api::V1
  class PasswordsController < Api::V1::BaseController

    before_action :authenticate_account!, only: :update

    def create
      account = Account.find_by!(email: params[:email])

      RestorePasswordService.new(account).execute

      render_created
    end

    def update
      token = params[:passwrod_reset_token]

      password = params[:password]
      password_confirmation = params[:password_confirmation]

      UpdatePasswordService.new(current_account).
        execute(token, password, password_confirmation)

      sign_out!
      render_ok
    end
  end
end
