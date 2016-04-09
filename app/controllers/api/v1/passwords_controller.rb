class Api::V1::PasswordsController < ApplicationController

  before_action :authenticate_account!, only: :update

  # Request that reset password
  def create
    email = params[:email]
    account = Account.find_by(email: email)

    # Fetch from modngodb # FIXME
    name = "sample_name"

    recovery_token = PasswordRecoveryToken.create_new_token(account)

    AccountMailer.reset_password(email, name, recovery_token.token).deliver
  end

  # Update password
  def update
    token = params[:token]
    new_password = params[:password]
    new_password_conf = params[:password_confirmation]

    recovery_token =
      current_account.password_recovery_tokens.find_by!(token: token)

    current_account.update!(
      password: new_password,
      password_confirmation: new_password_conf
    )

    recovery_token.disable

    render json: { result: true }
  end
end
