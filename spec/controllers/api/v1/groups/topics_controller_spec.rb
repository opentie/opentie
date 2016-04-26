require 'rails_helper'

module Api::V1::Groups
  RSpec.describe TopicsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:group) { Group.first }

    before do
      group.delegates.create(account: account)
    end

    describe "Authenticate" do
      before do
        xhr :get, :index, id_params
      end

      it '402 Unauthorized' do
        expect(response.status).to eq(401)
      end
    end

    describe "GET /api/v1/groups/topics" do
      before do
        sign_in!(account)
        xhr :get, :index, id_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/groups/topics/new" do
      before do
        sign_in!(account)
        xhr :get, :new, id_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/groups/topics/:id" do
      before do
        sign_in!(account)
        xhr :get, :show, id_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:topic)).to eq(true)
        expect(body[:topic].include?(:posts)).to eq(true)
        expect(body[:topic].include?(:tags)).to eq(true)
      end
    end

    describe "GET /api/v1/groups/topics/edit" do
      before do
        sign_in!(account)
        xhr :get, :edit, id_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'topic has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:topic)).to eq(true)
        expect(body[:topic].include?(:tags)).to eq(true)
      end
    end

    describe "PUT /api/v1/divisions/topics/" do
      before do
        sign_in!(account)

        params = {
          tag_list: ['tag', 'tagtag'],
          topic: FactoryGirl.attributes_for(:topic)
        }

        xhr :put, :update, id_params.merge(params)
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/topics/destroy" do
      before do
        sign_in!(account)

        @id = id_params[:id]
        xhr :delete, :destroy, id_params.merge({id: @id})
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'be deleted' do
        expect(Topic.where(id: @id)).to eq([])
      end
    end

    describe "POST /api/v1/groups/topics" do
      before do
        sign_in!(account)

        params = {
          tag_list: ['tag', 'tagtag'],
          topic: FactoryGirl.attributes_for(:topic)
        }

        xhr :post, :create, id_params.merge(params)
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    def id_params
      {
        group_id: group.id,
        id: group.topics.first.id
      }
    end
  end
end
