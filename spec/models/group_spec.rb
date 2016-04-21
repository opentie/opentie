require 'rails_helper'

RSpec.describe Group, type: :models do

  let(:account) { FactoryGirl.create(:account) }
  let(:group) { FactoryGirl.create(:group) }

  describe "Relationship" do
    it "has_many delegate" do
      expect do
        create_delegate
      end.to change { group.delegates.count }.by(1)
    end

    it "has_many accounts through delegates" do
      expect do
        create_delegate
      end.to change { group.accounts.count }.by(1)
    end

    it "has_many delegates dependent option" do
      create_delegate
      expect do
        group.accounts.first.destroy
      end.to change { group.delegates.count }.by(-1)
    end

    it "has_many topics" do
      topic = create_topic(FactoryGirl.create(:division))
      expect do
        GroupTopic.create(group: group, topic: topic)
      end.to change { group.topics.count }.to(1)
    end

    it "has_many uniq topics" do
      topic = create_topic(FactoryGirl.create(:division))
      expect do
        GroupTopic.create(group: group, topic: topic)
        GroupTopic.create(group: group, topic: topic)
      end.to change { group.topics.count }.to(1)
    end

    it "has_many proposal_topics" do
      expect do
        create_topic(group)
      end.to change { group.proposal_topics.count }.by(1)
    end
  end

  def create_delegate
    Delegate.create(account: account, group: group)
  end

  def create_post(topic)
    Post.create(
      FactoryGirl.attributes_for(:post).merge({
        author: account,
        topic: topic,
        group: group
      })
    )
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
