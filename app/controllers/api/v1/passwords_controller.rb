module Api::V1
  class PasswordsController < Api::V1::BaseController

    before_action :authenticate_account!, only: :update

    def create
      account = Account.find_by!(email: params[:email])

      RestorePasswordService.new(account).execute

      render_created
    end

    def update
      token = update_password_params[:password_reset_token]
      password = update_password_params[:password]
      password_confirmation = update_password_params[:password_confirmation]

      UpdatePasswordService.new(current_account).
        execute(token, password, password_confirmation)

      sign_out!
      render_ok
    end

    private

    def update_password_params
      params.permit(:password, :password_confirmation, :password_reset_token)
    end
  end
end
