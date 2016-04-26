require 'rails_helper'

module Api::V1::Divisions
  RSpec.describe TopicsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }

    before do
      division.roles.create(account: account, permission: 'normal')
    end

    describe "Authenticate" do
      before do
        xhr :get, :index, { division_id: division.id }
      end

      it '402 Unauthorized' do
        expect(response.status).to eq(401)
      end
    end

    describe "GET /api/v1/divisions/topics" do
      before do
        sign_in!(account)
        xhr :get, :index, { division_id: division.id}
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/divisions/topics/new" do
      before do
        sign_in!(account)
        xhr :get, :new, { division_id: division.id }
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/divisions/topics/:id" do
      before do
        sign_in!(account)
        xhr :get, :show, { division_id: division.id, id: Topic.first.id }
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'topic has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:topic)).to eq(true)
        expect(body[:topic].include?(:groups)).to eq(true)
        expect(body[:topic][:groups][0].include?(:group_topic_id)).to eq(true)
        expect(body[:topic][:groups][0].include?(:tags)).to eq(true)
      end
    end

    describe "GET /api/v1/divisions/topics/edit" do
      before do
        sign_in!(account)
        xhr :get, :edit, { division_id: division.id, id: Topic.first.id }
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'topic has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:topic)).to eq(true)
        expect(body[:topic].include?(:group_ids)).to eq(true)
        expect(body[:topic].include?(:tags)).to eq(true)
      end
    end

    describe "PUT /api/v1/divisions/topics/" do
      before do
        sign_in!(account)

        params = {
          division_id: division.id,
          id: Topic.first,
          group_ids: Group.pluck(:kibokan_id).take(5),
          tag_list: ['tag', 'tagtag']
        }
        params[:topic] = FactoryGirl.attributes_for(:topic)

        xhr :put, :update, params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/topics/destroy" do
      before do
        sign_in!(account)

        @id = Topic.first.id
        xhr :delete, :destroy, { division_id: division.id, id: @id }
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'be deleted' do
        expect(Topic.where(id: @id)).to eq([])
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
        expect(response.status).to eq(201)
      end
    end

  end
end
