module Api::V1
  class SessionsController < Api::V1::BaseController

    before_action :authenticate_account!, only: :sign_out

    def sign_in
      email = params[:email]
      account = Account.find_by!(email: email)

      password = params[:password]
      unless account.authenticate(password)
        render_unauthorized and return
      end

      sign_in!(account)
      render_created
    end

    def sign_out
      sign_out!
      render_created
    end
  end
end
