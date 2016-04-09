class Api::V1::Account::PasswordsController < ApplicationController

  before_action :authenticate_account!, only: :update

  # Request that reset password
  def create
    email = params[:email]
    account = Account.find_by(email: email)

    # Fetch from modngodb # FIXME
    name = "sample_name"

    token = PasswordRecoveryToken.create_new_token(account)

    AccountMailer.reset_password(email, name, token).deliver
  end

  # Update password
  def update
    token = params[:token]
    new_password = params[:password]

    recovery_token =
      current_account.password_recovery_tokens.find_by!(token: token)

    current_account.update!(password: new_password)

    recovery_token.disable

    render json: { result: true }
  end
end
