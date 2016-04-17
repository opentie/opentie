require 'rails_helper'

RSpec.describe Division, type: :models do
  let(:account) { FactoryGirl.create(:account) }
  let(:division) { FactoryGirl.create(:division) }

  describe "Relationship" do
    it "has_many roles" do
      expect do
        create_role
      end.to change { division.roles.count }.by(1)
    end

    it "has_many accounts through delegates" do
      expect do
        create_role
      end.to change { division.accounts.count }.by(1)
    end

    it "has_many proposal_topics" do
      expect do
        create_topic(division)
      end.to change { division.proposal_topics.count }.by(1)
    end
  end

  def create_role
    Role.create(account: account, division: division)
  end

  def create_topic(proposer)
    Topic.create(
      FactoryGirl.attributes_for(:topic).merge({
        proposer: proposer,
        author: account
      })
    )
  end
end
