require "rails_helper"

RSpec.describe AccountMailer, type: :mailer do
  before do
    @mail_to = 'opentie@example.com'
    @account_name = 'account_name'
    @mail_from = "do-not-reply.#{ Rails.application.config.global_config.organization_mail}"
    @sample_token = 'sample_token'
    @service_name = Rails.application.config.global_config.service_name
  end

  describe 'AccountMailer#reset_password' do
    let(:mail) do
      AccountMailer.reset_password(
        @mail_to,
        @account_name,
        @sample_token
      )
    end

    it 'send an email' do
      expect do
        mail.deliver_now
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq "#{@service_name}のパスワードリセット"
    end

    it "renders the receiver email" do
      expect(mail.to).to eq [@mail_to]
    end

    it "renders the sender email" do
      expect(mail.from).to eq [@mail_from]
    end
  end

  describe 'AccountMailer#regist_email' do
    let(:mail) do
      AccountMailer.regist_email(
        @mail_to,
        @account_name,
        @sample_token
      )
    end

    it 'send an email' do
      expect do
        mail.deliver_now
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq "#{@service_name}へこのメールアドレスでアカウント登録されました"
    end

    it "renders the receiver email" do
      expect(mail.to).to eq [@mail_to]
    end

    it "renders the sender email" do
      expect(mail.from).to eq [@mail_from]
    end
  end
end
