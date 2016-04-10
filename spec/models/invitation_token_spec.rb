require 'rails_helper'

RSpec.describe InvitationToken, type: :models do

  let(:division) { FactoryGirl.create(:division) }
  let(:email) { "opentie@example.com" }

  describe "Useful methods" do
    it "create change password token" do
      expect do
        create_new_token
      end.to change { division.invitation_tokens.count }.by(1)
    end
  end

  describe "Primitive methods" do
    it "swith disable" do
      expect do
        token = create_new_token
        token.disable
      end.to change { division.invitation_tokens.count }.by(0)
    end

    it "swith enable" do
      expect do
        token = create_new_token
        token.disable
        token.enable
      end.to change { division.invitation_tokens.count }.by(1)
    end
  end

  def create_new_token
    InvitationToken.create_new_token(division, email)
  end
end
