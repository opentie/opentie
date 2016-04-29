require 'rails_helper'

RSpec.describe InviteAccountService, type: :services do
  let(:account) { FactoryGirl.create(:account) }
  let(:division) { FactoryGirl.create(:division) }
  let(:group) { FactoryGirl.create(:group) }

  describe "execute with division" do
    it "increase normal account in division" do
      expect do
        create_division_with_account
      end.to change {
        division.roles.where(permission: 'normal').count
      }.by(1)
    end

    it "sended invitation_email" do
      expect do
        create_division_with_email
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it "increase invite tokens" do
      expect do
        create_division_with_email
      end.to change { InvitationToken.where(email: "sample@opentie.com").count }.by(1)
    end
  end

  describe "execute with group" do
    it "increase normal account in group" do
      expect do
        create_group_with_account
      end.to change {
        group.delegates.where(permission: 'normal').count
      }.by(1)
    end

    it "sended invitation_email" do
      expect do
        create_group_with_email
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it "increase invite tokens" do
      expect do
        create_group_with_email
      end.to change { InvitationToken.where(email: "sample@opentie.com").count }.by(1)
    end
  end

  def create_division_with_account
    InviteAccountService.
      new(division).
      execute(account.email, 'normal')
  end

  def create_division_with_email
    InviteAccountService.
      new(division).
      execute("sample@opentie.com", 'normal')
  end

  def create_group_with_account
    InviteAccountService.
      new(group).
      execute(account.email, 'normal')
  end

  def create_group_with_email
    InviteAccountService.
      new(group).
      execute("sample@opentie.com", 'normal')
  end
end
