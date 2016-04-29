require 'rails_helper'

module Api::V1::Divisions::Categories
  RSpec.describe TopicsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }
    let(:topic) { Topic.first }

    before do
      sign_in!(account)
      division.roles.create(account: account, permission: 'normal')
    end

    describe "GET /api/v1/divisions/topics" do
      before do
        xhr :get, :index, default_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/divisions/topics/new" do
      before do
        xhr :get, :new, default_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/divisions/topics/:id" do
      before do
        xhr :get, :show, topic_params
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
        xhr :get, :edit, topic_params
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
        xhr :put, :update, store_params.merge(topic_params)
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/topics/destroy" do
      before do
        @id = topic_params[:id]
        xhr :delete, :destroy, topic_params
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
        xhr :post, :create, store_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    def default_params
      {
        division_id: division.id,
        category_name: 'category_name'
      }
    end

    def store_params
      default_params.merge({
        topic: FactoryGirl.attributes_for(:topic),
        tag_list: ['tag', 'tagtag'],
        group_ids: Group.pluck(:kibokan_id).take(5)
      })
    end

    def topic_params
      default_params.merge({
        id: topic.id
      })
    end
  end
end
