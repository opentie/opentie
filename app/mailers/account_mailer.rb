class AccountMailer < ApplicationMailer
  layout 'basic'

  def reset_password(email, name, token)
    @account_name = name
    @account_email = email

    @project_name = "opentie" # FIXME
    @confirm_url = "/account/password_reset_form?token=#{token}" # FIXME

    mail to: email, subject: "#{@project_name}のパスワードリセット"
  end

  def regist_email(email, name, token)
    @account_name = name
    @account_email = email

    @project_name = "opentie" # FIXME
    @confirm_url = "/account/email_confirm?token=#{token}" # FIXME

    mail to: email, subject: "#{@project_name}にこのメールアドレスでアカウント登録されました"
  end
end
