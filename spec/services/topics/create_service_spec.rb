require 'rails_helper'

module Topics
  RSpec.describe CreateService, type: :services do
    let(:group) { FactoryGirl.create(:group) }
    let(:division) { FactoryGirl.create(:division) }
    let(:account) { FactoryGirl.create(:account) }

    describe "initialize" do
      it "new" do
        service = new_topic(division)
        expect(service.class).to eq(Topics::CreateService)
      end
    end

    describe "execute" do
      before do
        @groups = 10.times.map do |i|
          group = FactoryGirl.create(:group)
          group.kibokan_id = i + 100
        end
      end

      it "create published topic" do
        expect do
          create_topic(division, @groups, false)
        end.to change { division.proposal_topics.published.count }.by(1)
      end

      it "create draft topic" do
        expect do
          create_topic(division, @groups, true)
        end.to change { division.proposal_topics.draft.count }.by(1)
      end
    end

    def new_topic(proposer)
      Topics::CreateService.new(proposer)
    end

    def create_topic(proposer, group_ids, is_draft)
      Topics::CreateService.new(proposer).execute(
        {
          title: "title",
          description: "des",
          is_draft: is_draft,
          account: account
        },
        group_ids
      )
    end
  end
end
