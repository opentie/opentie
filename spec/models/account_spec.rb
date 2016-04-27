require 'rails_helper'

RSpec.describe Account, type: :models do
  describe "Create column" do
    it "valid params" do
      account = Account.new(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0
      )
      expect(account).to be_valid
    end

    it "invalid password and password_confirmation" do
      account = Account.new(
        password: "password",
        password_confirmation: "wrong_password",
        kibokan_id: 0
      )
      expect(account).not_to be_valid
    end

    it "disallow conflict email" do
      Account.create(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0,
        email: "opentie@example.com"
      )
      account = Account.new(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0,
        email: "opentie@example.com"
      )
      expect(account).not_to be_valid
    end

    it "allow conflict email that value is nil" do
      Account.create(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0,
        email: nil
      )
      account = Account.new(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0,
        email: nil
      )
      expect(account).to be_valid
    end
  end

  describe "create and update methods" do
    before do
      @account = FactoryGirl.create(:account)
      @email = @account.email
    end

    it "create_with_kibokan" do
      params = {
        password: "password",
        password_confirmation: "password",
        kibokan: {}
      }

      expect do
        Account.create_with_kibokan(params)
      end.to change { Account.all.count }.by(1)
    end

    it "update_with_kibokan" do
      expect(@account.email).to eq(@email)

      params = {
        email: "chenged@opentie.com",
        kibokan: {}
      }

      @account.update_with_kibokan(params)
      expect(Account.find(@account.id).email).not_to eq(@email)
    end
  end

  describe "Instance methods" do
    it "#confirmed_reset_password?" do
      account = FactoryGirl.create(:account)

      expect(account.confirmed_reset_password?).to eq(true)

      recovery_token =
        PasswordRecoveryToken.create_new_token(account)

      expect(account.confirmed_reset_password?).to eq(false)

      UpdatePasswordService.new(account).
        execute(recovery_token.token, "password", "password")

      expect(account.confirmed_reset_password?).to eq(true)
    end

    it "#confirmed_reset_email?" do
      account = FactoryGirl.create(:account)

      expect(account.confirmed_reset_email?).to eq(true)

      recovery_token =
        EmailRecoveryToken.create_new_token(account, "opentie@example.com")

      expect(account.confirmed_reset_email?).to eq(false)

      UpdateEmailService.new(account).execute(recovery_token.token)

      expect(account.confirmed_reset_email?).to eq(true)
    end

    it "#confirmed_email_first_time?" do
      account = Account.create(
        password: "password",
        password_confirmation: "password",
        kibokan_id: 0,
        email: nil
      )

      expect(account.confirmed_email_first_time?).to eq(false)

      recovery_token =
        EmailRecoveryToken.create_new_token(account, "opentie@example.com")

      UpdateEmailService.new(account).execute(recovery_token.token)

      expect(account.confirmed_email_first_time?).to eq(true)
    end
  end
end
