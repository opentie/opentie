class Api::V1::AccountsController < ApplicationController

  before_action :authenticate_account!, only: [:edit, :update]

  def new
    # return schema from mongodb
    # FIXME
    render json: { result: true }
  end

  def create
    register_attributes = params.slice(
      :password, :password_confirmation, :kibokan
    ).symbolize_keys

    account = Account.create_with_kibokan(register_attributes)
    email = params[:kibokan][:email]
    Accounts::RegisterEmailService.new(account, email).execute

    render json: { result: true }
  end

  def edit
    # return schema from mongodb
    # FIXME
    render json: { result: true }
  end

  def email_confirm
    token = params[:email_set_token]

    recovery_token = EmailRecoveryToken.find_by!(token: token)
    account = recovery_token.account

    Accounts::UpdateEmailService.new(account, recovery_token).execute

    sign_in!(account)
    render json: { result: true }
  end

  def update
    if params[:email] != current_account.email
      Accounts::RegisterEmailService.new(current_account, params[:email]).execute
      params[:email] = current_account.email
    end

    current_account.update_with_kibokan(params)

    render json: { result: true }
  end
end
