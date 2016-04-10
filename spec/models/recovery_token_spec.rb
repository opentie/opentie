require 'rails_helper'

RSpec.describe RecoveryToken, type: :models do
  describe "Change password flow" do
    let(:account) { FactoryGirl.create(:account) }

    it "create origin recovery_token" do
      expect do
        RecoveryToken.create(account: account)
      end.to change { account.recovery_tokens.count }.by(1)
    end

    it "swith disable" do
      expect do
        recovery_token = RecoveryToken.create(account: account)
        recovery_token.disable
      end.to change { account.recovery_tokens.count }.by(0)
    end

    it "swith enable" do
      expect do
        recovery_token = RecoveryToken.create(account: account)
        recovery_token.disable
        recovery_token.enable
      end.to change { account.recovery_tokens.count }.by(1)
    end
  end
end
