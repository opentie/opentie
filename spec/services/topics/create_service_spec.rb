require 'rails_helper'

module Topics
  RSpec.describe CreateService, type: :services do
    let(:group) { FactoryGirl.create(:group) }
    let(:division) { FactoryGirl.create(:division) }
    let(:account) { FactoryGirl.create(:account) }

    describe "execute" do
      it "create published topic" do
        expect do
          create_topic(division, false, group_ids(100))
        end.to change { division.proposal_topics.published.count }.by(1)
      end

      it "create draft topic" do
        expect do
          create_topic(division, true, group_ids(200))
        end.to change { division.proposal_topics.draft.count }.by(1)
      end

      it "topic_group has tag_list" do
        topic = create_topic(division, true, group_ids(300))
        group_topic = GroupTopic.where(topic: topic).first
        expect(group_topic.tag_list.count).to eq(2)
      end

    end

    def group_ids(prefix)
      10.times.map do |i|
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
      Topics::CreateService.new(proposer, account).execute(params)
    end
  end
end
