require 'rails_helper'

RSpec.describe Group, type: :models do
  let(:account) { FactoryGirl.create(:account) }
  let(:group) { Group.first }

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
      end.to change { group.topics.count }.by(1)
    end

    it "has_many uniq topics" do
      topic = create_topic(FactoryGirl.create(:division))
      expect do
        GroupTopic.create(group: group, topic: topic)
        GroupTopic.create(group: group, topic: topic)
      end.to change { group.topics.count }.by(1)
    end

    it "has_many proposal_topics" do
      expect do
        create_topic(group)
      end.to change { group.proposal_topics.count }.by(1)
    end
  end

  describe "create and update methods" do
    before do
      @params = {
        kibokan: {},
        category_name: group.category_name
      }
    end

    it "create_with_kibokan" do
      expect do
        Group.create_with_kibokan(@params)
      end.to change { Group.all.count }.by(1)
    end

    it "update_with_kibokan" do
      params = {
        kibokan: { hoge: 123 },
        is_froze: false
      }

      id = group.kibokan_id
      group.update_with_kibokan(params)
      expect(Group.find(group.id).kibokan_id).not_to eq(id)
    end

    it "update_with_kibokan, decrease active groups" do
      params = {
        kibokan: { hoge: 123 },
        is_froze: true
      }

      expect do
        group.update_with_kibokan(params)
      end.to change { Group.active.count }.by(-1)
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
