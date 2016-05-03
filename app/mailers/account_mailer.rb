class AccountMailer < ApplicationMailer
  layout 'tie-basic'
  default from: "do-not-reply.#{Rails.application.config.global_config.organization_mail}"

  before_action :load_application_setting

  def reset_password(email, name, token)
    @account_name = name
    @account_email = email

    @confirm_url = "#{service_host}passwords?password_reset_token=#{token}"

    mail to: email, subject: "#{@service_name}のパスワードリセット"
  end

  def regist_email(email, name, token)
    @account_name = name
    @account_email = email

    @confirm_url = "#{service_host}account/email_confirm?email_set_token=#{token}"

    mail to: email, subject: "#{@service_name}へこのメールアドレスでアカウント登録されました"
  end

  def invite_organization(organization_name, email)
    @organization_name = organization_name
    @account_email = email

    @account_form_url = "#{service_host}account/new"

    mail to: email, subject: "#{@service_name}へこのメールアドレスに招待がありました"
  end

  def announce_account(email, subject, message)
    @organization_name = organization_name
    @account_email = email

    @message = message

    mail to: email, subject: subject
  end

  private

  def load_application_setting
    @service_name = service_name
    @organization_name = organization_name
    @organization_mail = organization_mail
    @organization_tel = organization_tel
  end

  def service_name
    Rails.application.config.global_config.service_name
  end

  def service_host
    ENV['SERVICE_HOSTURL']
  end

  def organization_name
    Rails.application.config.global_config.organization_name
  end

  def organization_mail
    Rails.application.config.global_config.organization_mail
  end

  def organization_tel
    Rails.application.config.global_config.organization_tel
  end
end
