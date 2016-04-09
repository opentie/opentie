require 'rails_helper'

RSpec.describe EmailRecoveryToken, type: :models do
  before do
    @new_email = "new@email.com"
  end

  describe "Change email flow" do
    let(:account) { FactoryGirl.create(:account) }

    it "create change email token" do
      expect do
        EmailRecoveryToken.create_new_token(account, @new_email)
      end.to change { account.email_recovery_tokens.count }.by(1)
    end

    it "do not conflict token" do
      expect do
        EmailRecoveryToken.create_new_token(account, @new_email)
        EmailRecoveryToken.create_new_token(account, @new_email)
      end.to change { account.email_recovery_tokens.count }.by(1)
    end

    it "change email" do
      recovery_token = EmailRecoveryToken.create_new_token(account, @new_email)
      account.update_email_with_recovery_token(recovery_token.token)
      expect(account.email).to eq(@new_email)
    end
  end
end
