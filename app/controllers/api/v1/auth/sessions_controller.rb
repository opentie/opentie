class Api::V1::Auth::SessionsController < ApplicationController

  before_action :authenticate_account!, only: :sign_out

  def sign_in
    email = params[:email]
    account = Account.find_by!(email: email)

    password = params[:password]
    unless account.authenticate(password)
      render_unauthorized and return
    end

    sign_in!(account)

    render json: { status: 200 }
  end

  def sign_out
    sign_out!
    render json: { status: 200 }
  end
end
