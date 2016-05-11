require 'rails_helper'

module Api::V1::Divisions::Categories
  RSpec.describe GroupsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { Division.first }


    describe 'GET /api/v1/divisions/:division_id/categories/:category_name/groups' do
      before do
        division.roles.create(account: account, permission: 'normal')
        sign_in!(account)
        xhr :get, :index, default_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:groups)).to eq(true)
        expect(body[:groups].class).to eq(Array)
      end
    end

    def default_params
      {
        division_id: division.id,
        category_name: Group.first.category_name
      }
    end
  end
end
