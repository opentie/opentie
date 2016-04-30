require 'rails_helper'

module Api::V1::Divisions
  RSpec.describe GroupsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:group) { FactoryGirl.create(:group) }
    let(:division) { FactoryGirl.create(:division) }

    before do
      division.roles.create(account: account, permission: 'super')
      group.delegates.create(account: account)
      sign_in!(account)
    end

    describe 'GET api/v1/divisions/:division_id/groups/:id' do
      before do
        xhr :get, :show, group_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:kibokan)).to eq(true)
        expect(body.include?(:id)).to eq(true)
        expect(body.include?(:members)).to eq(true)
        expect(body[:members].first.include?(:id)).to eq(true)
        expect(body[:members].first.include?(:permission)).to eq(true)
        expect(body[:members].first.include?(:email)).to eq(true)
        expect(body[:members].first.include?(:kibokan)).to eq(true)
      end
    end

    describe 'GET api/v1/divisions/:division_id/groups/edit' do
      before do
        xhr :get, :edit, group_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:kibokan)).to eq(true)
        expect(body.include?(:id)).to eq(true)
        expect(body.include?(:members)).to eq(true)
        expect(body[:members].first.include?(:id)).to eq(true)
        expect(body[:members].first.include?(:permission)).to eq(true)
        expect(body[:members].first.include?(:email)).to eq(true)
        expect(body[:members].first.include?(:kibokan)).to eq(true)
      end
    end

    describe 'POST api/v1/divisions/:division_id/groups/:id' do
      before do
        xhr :put, :update, store_params.merge(group_params)
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    def default_params
      {
        division_id: division.id,
      }
    end

    def store_params
      default_params.merge({
        kibokan: {},
        group: FactoryGirl.attributes_for(:group)
      })
    end

    def group_params
      default_params.merge({
        id: group.id
      })
    end
  end
end
