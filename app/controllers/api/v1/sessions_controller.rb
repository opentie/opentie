module Api::V1
  class SessionsController < Api::V1::BaseController

    before_action :authenticate_account!, only: :sign_out

    def sign_in
      email = sign_in_params[:email]
      password = sign_in_params[:password]

      account = Account.find_by(email: email)
      render_unauthorized and return unless account

      login_result = account.authenticate(password)
      render_unauthorized and return unless login_result

      sign_in!(account)
      render_created
    end

    def sign_out
      sign_out!
      render_created
    end

    private

    def sign_in_params
      params.permit(:email, :password)
    end
  end
end
