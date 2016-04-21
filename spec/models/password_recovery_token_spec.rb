require 'rails_helper'

RSpec.describe PasswordRecoveryToken, type: :models do

  let(:account) { FactoryGirl.create(:account) }

  describe "useful methods" do

    it "create change password token" do
      expect do
        create_new_token
      end.to change { account.password_recovery_tokens.count }.by(1)
    end

    it "do not conflict token" do
      expect do
        create_new_token
        create_new_token
      end.to change { account.password_recovery_tokens.count }.by(1)
    end
  end

  describe "Primitive methods" do
    it "swith disable" do
      expect do
        recovery_token = create_new_token
        recovery_token.disable
      end.to change { account.password_recovery_tokens.count }.by(0)
    end

    it "swith enable" do
      expect do
        recovery_token = create_new_token
        recovery_token.disable
        recovery_token.enable
      end.to change { account.password_recovery_tokens.count }.by(1)
    end
  end

  def create_new_token
    PasswordRecoveryToken.create_new_token(account)
  end
end
