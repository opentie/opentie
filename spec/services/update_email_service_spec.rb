require 'rails_helper'

RSpec.describe UpdateEmailService, type: :services do
  let(:account) { FactoryGirl.create(:account) }

  before do
    @service = create_update_email_service(account)
    @new_email = "new-opentie@example.com"
    @token = create_token(@new_email)

  end

  describe "initialize" do
    it "new" do
      expect(@service.class).to eq(UpdateEmailService)
    end
  end

  describe "execute" do
    it "decrese email_recovery_token" do
      expect do
        @service.execute(@token)
      end.to change { EmailRecoveryToken.all.count }.by(-1)
    end

    it "updated email" do
      @service.execute(@token)
      updated_account = Account.find(account.id)
      expect(updated_account.email).to eq(@new_email)
    end
  end

  def create_update_email_service(account)
    UpdateEmailService.new(account)
  end

  def create_token(email)
    EmailRecoveryToken.create_new_token(account, email).token
  end
end
