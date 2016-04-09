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
  end
end
