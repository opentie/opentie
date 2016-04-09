class AccountMailer < ApplicationMailer
  layout 'tie-basic'
  default from: "do-not-reply.#{Rails.application.config.global_config.organization_mail}"

  def reset_password(email, name, token)
    @account_name = name
    @account_email = email

    @service_name = service_name
    @organization_name = organization_name
    @organization_mail = organization_mail
    @organization_tel = organization_tel

    @confirm_url = "/account/password_reset_form?token=#{token}" # FIXME

    mail to: email, subject: "#{@project_name}のパスワードリセット"
  end

  def regist_email(email, name, token)
    @account_name = name
    @account_email = email

    @project_name = application_name
    @organization_name = organization_name
    @organization_mail = organization_mail
    @organization_tel = organization_tel
    binding.pry

    @confirm_url = "/account/email_confirm?token=#{token}" # FIXME

    mail to: email, subject: "#{@project_name}へこのメールアドレスでアカウント登録されました"
  end

  private

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
