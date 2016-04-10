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
    Accounts::RegisterEmailService.new(account).execute(email)

    render json: { result: true }
  end

  def edit
    current_account
    # return schema from mongodb
    # FIXME
    render json: { result: true }
  end

  def email_confirm
    token = params[:email_set_token]
    account = EmailRecoveryToken.find_by!(token: token).account

    Accounts::UpdateEmailService.new(account).execute(token)

    sign_in!(account)
    render json: { result: true }
  end

  def update
    if params[:email] != current_account.email
      Accounts::RegisterEmailService.new(current_account).execute(params[:email])
      params[:email] = current_account.email
    end

    current_account.update_with_kibokan(params[:kibokan])

    render json: { result: true }
  end
end
