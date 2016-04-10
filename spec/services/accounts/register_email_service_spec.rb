require 'rails_helper'

RSpec.describe Accounts::RegisterEmailService, type: :services do
  let(:account) { FactoryGirl.create(:account) }

  before do
    @service = create_register_email_service(account)
  end

  describe "initialize" do
    it "new" do
      expect(@service.class).to eq(Accounts::RegisterEmailService)
    end
  end

  describe "execute" do
    it "increse email_recovery_token" do
      expect do
        @service.execute("new-opentie@example.com")
      end.to change { EmailRecoveryToken.all.count }.by(1)
    end

    it "increse sended email" do
      expect do
        @service.execute("new-opentie@example.com")
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  def create_register_email_service(account)
    Accounts::RegisterEmailService.new(account)
  end
end
