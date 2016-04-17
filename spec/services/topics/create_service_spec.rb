require 'rails_helper'

module Topics
  RSpec.describe CreateService, type: :services do
    let(:group) { FactoryGirl.create(:group) }
    let(:division) { FactoryGirl.create(:division) }
    let(:account) { FactoryGirl.create(:account) }

    describe "execute" do
      before do
        @groups = 10.times.map do |i|
          group = FactoryGirl.create(:group)
          group.kibokan_id = i + 100
          group.save
        end
      end

      it "create published topic" do
        expect do
          create_topic(division, false, @groups)
        end.to change { division.proposal_topics.published.count }.by(1)
      end

      it "create draft topic" do
        expect do
          create_topic(division, true, @groups)
        end.to change { division.proposal_topics.draft.count }.by(1)
      end
    end

    def create_topic(proposer, is_draft,  group_ids)
      Topics::CreateService.new(proposer).execute(
        {
          title: "title",
          description: "des",
        },
        account,
        is_draft,
        group_ids
      )
    end
  end
end
