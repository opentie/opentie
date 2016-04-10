require 'rails_helper'

RSpec.describe PasswordRecoveryToken, type: :models do
  describe "Change password flow" do
    let(:account) { FactoryGirl.create(:account) }

    it "create change password token" do
      expect do
        PasswordRecoveryToken.create_new_token(account)
      end.to change { account.password_recovery_tokens.count }.by(1)
    end

    it "do not conflict token" do
      expect do
        PasswordRecoveryToken.create_new_token(account)
        PasswordRecoveryToken.create_new_token(account)
      end.to change { account.password_recovery_tokens.count }.by(1)
    end

    it "change password" do
      recovery_token = PasswordRecoveryToken.create_new_token(account)

      Accounts::UpdatePasswordService.
        new(account, recovery_token).
        execute("new-password", "new-password")

      expect(account.authenticate("new-password")).to eq(account)
    end
  end
end
