require 'rails_helper'

module Topics
  RSpec.describe UpdateService, type: :services do
    let(:group) { FactoryGirl.create(:group) }
    let(:division) { FactoryGirl.create(:division) }
    let(:account) { FactoryGirl.create(:account) }

    describe "execute" do
      before do
        @groups = 10.times.map do |i|
          group = FactoryGirl.create(:group)
          group.kibokan_id = i + 100
          group.save
          group.kibokan_id
        end
      end

      it "create published topic and update title" do
        topic = create_publish_topic(division, @groups)
        update_topic(topic, 'title2', topic.is_draft, @groups)

        expect(topic.title).to eq('title2')
      end

      it "create draft topic and update published" do
        topic = create_draft_topic(division, @groups)

        expect(topic.draft?).to eq(true)
        expect(topic.publish?).to eq(false)

        update_topic(topic, topic.title, false, @groups)

        expect(topic.draft?).to eq(false)
        expect(topic.publish?).to eq(true)
      end

      it "create published topic and update title by division" do
        topic = create_publish_topic(division, @groups)

        new_groups = 5.times.map do |i|
          group = FactoryGirl.create(:group)
          group.kibokan_id = i + 200
          group.save
          group.kibokan_id
        end

        expect do
          update_topic(topic, topic.title, topic.is_draft, new_groups)
        end.to change { topic.groups.count }.by(-5)
      end

      it "create published topic and update title by group" do
        topic = create_publish_topic(group, @groups)

        new_groups = 5.times.map do |i|
          group = FactoryGirl.create(:group)
          group.kibokan_id = i + 200
          group.save
          group.kibokan_id
        end

        expect do
          update_topic(topic, topic.title, topic.is_draft, new_groups)
        end.to change { topic.groups.count }.by(-5)
      end

    end

    def update_topic(topic, title, is_draft, group_ids)
      Topics::UpdateService.new(topic).execute(
        {
          title: title,
          description: 'des',
        },
        is_draft,
        group_ids
      )
    end

    def create_draft_topic(proposer, group_ids)
      create_topic(proposer, true, group_ids)
    end

    def create_publish_topic(proposer, group_ids)
      create_topic(proposer, false, group_ids)
    end

    def create_topic(proposer, is_draft, group_ids)
      Topics::CreateService.new(proposer).execute(
        {
          title: 'title',
          description: 'des',
        },
        account,
        is_draft,
        group_ids
      )
    end
  end
end
