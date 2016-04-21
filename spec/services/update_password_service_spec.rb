require 'rails_helper'

RSpec.describe UpdatePasswordService, type: :services do
  let(:account) { FactoryGirl.create(:account) }

  before do
    @service = create_update_password_service(account)
    @token = create_token

    @password = "new-password"
    @password_confirmation = "new-password"
  end

  describe "initialize" do
    it "new" do
      expect(@service.class).to eq(UpdatePasswordService)
    end
  end

  describe "execute" do
    it "decrese password_recovery_token" do
      expect do
        @service.execute(@token, @password, @password_confirmation)
      end.to change { PasswordRecoveryToken.all.count }.by(-1)
    end

    it "updated email" do
      @service.execute(@token, @password, @password_confirmation)
      updated_account = Account.find(account.id)
      expect(updated_account.authenticate(@password)).to eq(updated_account)
    end
  end

  def create_update_password_service(account)
    UpdatePasswordService.new(account)
  end

  def create_token
    PasswordRecoveryToken.create_new_token(account).token
  end
end
