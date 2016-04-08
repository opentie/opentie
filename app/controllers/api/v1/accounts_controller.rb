class Api::V1::AccountsController < ApplicationController

  before_action :authenticate_account!, only: [:edit, :update]

  def new
    # return schema from mongodb
    # FIXME
  end

  def create
    account = Account.new(
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )

    # no match password
    raise ActiveRecord::RecordInvalid unless account.valid?

    columns = params[:form][:columns] # FIXME
    email = columns[:email]
    columns[:email] = nil # do not save yet

    # request that save column to mongodb # FIXME
    kibokan_id = (0..100).to_a.sample

    account.kibokan_id = kibokan_id
    account.save!

    token = EmailRecoveryToken.create_new_token(account.id, email)
    send_regist_mail(email, token)

    render json: { result: true }
  end

  def edit
    # return schema from mongodb
    # FIXME
  end

  def email_confirm
    token = params[:email_set_token]
    account = EmailRecoveryToken.find_by!(token: token).account
    account.update_email_with_recovery_token(token)

    sign_in!(account)
    render json: { result: true }
  end

  def update
    columns = params[:form][:columns] # FIXME
    if columns[:email] != current_account.email
      token = EmailRecoveryToken.create_new_token(current_account.id, columns[:email])
      send_regist_mail(columns[:email], token)
      columns[:email] = current_account.email
    end

    # update mongodata with column
    # FIXME

    render json: { result: true }
  end

  private

  def send_regist_mail(email, token)
    # get account name from mongodb
    name = "sample_name"
    AccountMailer.regist_email(email, name, token).deliver
  end
end
