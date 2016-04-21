require 'rails_helper'
require 'api/v1/sessions_controller'

module Api::V1::Divisions
  RSpec.describe TopicsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }

    describe "GET /api/v1/divisions/topics" do
      before do
        sign_in!(account)
        xhr :get, :index, { division_id: division.id }
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/topics" do
      before do
        sign_in!(account)

        params = {
          division_id: division.id,
          group_ids: Group.pluck(:kibokan_id).take(5),
          tag_list: ['tag', 'tagtag']
        }
        params[:topic] = FactoryGirl.attributes_for(:topic)

        xhr :post, :create, params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

  end
end
