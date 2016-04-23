require 'rails_helper'

module Api::V1::Divisions::GroupTopics
  RSpec.describe GroupTopicsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }

    describe "GET /divisions/:division_id/group_topics/:id" do
      before do
        sign_in!(account)

        params = {
          division_id: Division.first.id,
          id: GroupTopic.first.id
        }

        xhr :get, :show, params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:group_topic)).to eq(true)
        expect(body[:group_topic].include?(:tags)).to eq(true)
        expect(body[:group_topic].include?(:posts)).to eq(true)
      end
    end
  end
end
