require 'rails_helper'

RSpec.describe Accounts::RestorePasswordService, type: :services do
  let(:account) { FactoryGirl.create(:account) }

  before do
    @service = create_restore_password_service(account)
  end

  describe "initialize" do
    it "new" do
      expect(@service.class).to eq(Accounts::RestorePasswordService)
    end
  end

  describe "execute" do
    it "increse password_recovery_token" do
      expect do
        @service.execute
      end.to change { PasswordRecoveryToken.all.count }.by(1)
    end

    it "increse sended email" do
      expect do
        @service.execute
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  def create_restore_password_service(account)
    Accounts::RestorePasswordService.new(account)
  end
end
