class AccountMailer < ApplicationMailer
  layout 'tie-basic'
  default from: "do-not-reply.#{Rails.application.config.global_config.organization_mail}"

  before_action :load_application_setting

  def reset_password(email, name, token)
    @account_name = name
    @account_email = email

    @confirm_url = "/account/password_reset_form?token=#{token}" # FIXME

    mail to: email, subject: "#{@service_name}のパスワードリセット"
  end

  def regist_email(email, name, token)
    @account_name = name
    @account_email = email

    @confirm_url = "/account/email_confirm?token=#{token}" # FIXME

    mail to: email, subject: "#{@service_name}へこのメールアドレスでアカウント登録されました"
  end

  def invite_organization(organization_name, email)
    @organization_name = organization_name
    @account_email = email

    @account_form_url = "/account/new" # FIXME

    mail to: email, subject: "#{@service_name}へこのメールアドレスに招待がありました"
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
