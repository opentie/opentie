require 'rails_helper'

RSpec.describe UpdateTopicService, type: :services do
  let(:group) { FactoryGirl.create(:group) }
  let(:division) { FactoryGirl.create(:division) }
  let(:account) { FactoryGirl.create(:account) }

  describe "execute" do

    it "create published topic and update title" do
      topic = create_publish_topic(division, group_ids)
      update_topic(topic, 'title2', topic.is_draft, group_ids)

      expect(topic.title).to eq('title2')
    end

    it "create draft topic and update published" do
      topic = create_draft_topic(division, group_ids)

      expect(topic.draft?).to eq(true)
      expect(topic.published?).to eq(false)

      update_topic(topic, topic.title, false, group_ids)

      expect(topic.draft?).to eq(false)
      expect(topic.published?).to eq(true)
    end

    it "create published topic and update groups by division" do
      topic = create_publish_topic(division, group_ids)

      new_group_ids = group_ids(5, 200)

      expect do
        update_topic(topic, topic.title, topic.is_draft, new_group_ids)
      end.to change { topic.groups.count }.by(-5)
    end

    it "create published topic and update groups by group" do
      topic = create_publish_topic(group, group_ids)

      new_group_ids = group_ids(5, 200)

      expect do
        update_topic(topic, topic.title, topic.is_draft, new_group_ids)
      end.to change { topic.groups.count }.by(-5)
    end

    it "create published topic and update tag_list" do
      topic = create_publish_topic(group, group_ids)

      expect do
        update_topic(topic, topic.title, topic.is_draft, group_ids)
      end.to change {
        GroupTopic.where(topic: topic, group: group).first.tag_list.count
      }.by(1)
    end

  end

  def update_topic(topic, title, is_draft, group_ids)
    params = {
      title: title,
      description: "des",
      is_draft: is_draft,
      group_ids: group_ids,
      tag_list: "tag1, tag2, tag3"
    }

    UpdateTopicService.new(topic).execute(params)
  end

  def create_draft_topic(proposer, group_ids)
    create_topic(proposer, true, group_ids)
  end

  def create_publish_topic(proposer, group_ids)
    create_topic(proposer, false, group_ids)
  end

  def group_ids(num = 10, prefix = 100)
    num.times.map do |i|
      group = FactoryGirl.create(:group)
      group.kibokan_id = i + prefix
      group.save
      group.kibokan_id
    end
  end

  def create_topic(proposer, is_draft,  group_ids)
    params = {
      title: "title",
      description: "des",
      is_draft: is_draft,
      group_ids: group_ids,
      tag_list: "tag1, tag2"
    }
    CreateTopicService.new(proposer, account).execute(params)
  end
end
