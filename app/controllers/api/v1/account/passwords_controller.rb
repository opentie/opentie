class Api::V1::Account::PasswordsController < ApplicationController

  before_action :authenticate_account!, only: :update

  def create
    account = Account.find_by!(email: params[:email])

    Accounts::RestorePasswordService.new(account).execute

    render json: { result: true }
  end

  def update
    token = params[:passwrod_reset_token]

    password = params[:password]
    password_confirmation = params[:password_confirmation]

    Accounts::UpdatePasswordService.
      new(current_account).
      execute(token, password, password_confirmation)

    sign_out!

    render json: { result: true }
  end
end
