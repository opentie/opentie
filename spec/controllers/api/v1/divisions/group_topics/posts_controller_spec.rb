require 'rails_helper'

module Api::V1::Divisions::GroupTopics
  RSpec.describe PostsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }
    let(:group_topic) { GroupTopic.first }

    before do
      division.roles.create(account: account, permission: 'normal')
    end

    describe "GET /divisions/:division_id/group_topics/:group_topic_id/posts/draft" do
      before do
        sign_in!(account)
        xhr :get, :draft, id_params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:posts)).to eq(true)
      end
    end

    describe "GET /divisions/:division_id/group_topics/:group_topic_id/posts/new" do
      before do
        sign_in!(account)
        xhr :get, :new, id_params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /divisions/:division_id/group_topics/:group_topic_id/posts" do
      before do
        sign_in!(account)
        xhr :post, :create, id_params.merge(post_params)
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /divisions/:division_id/group_topics/:group_topic_id/posts/edit/:id" do
      before do
        sign_in!(account)
        xhr :get, :edit, id_params.merge({ id: group_topic.posts.first.id })
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:post)).to eq(true)
      end
    end

    describe "PUT /divisions/:division_id/group_topics/:group_topic_id/posts/:id" do
      before do
        sign_in!(account)

        params = id_params.merge(post_params).merge({ id: group_topic.posts.first.id })
        xhr :put, :update, params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    def id_params
      {
        division_id: division.id,
        group_topic_id: group_topic.id
      }
    end

    def post_params
      { post: FactoryGirl.attributes_for(:post) }
    end
  end
end
