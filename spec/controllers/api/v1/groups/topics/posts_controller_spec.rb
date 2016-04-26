require 'rails_helper'

module Api::V1::Groups::Topics
  RSpec.describe PostsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:group) { FactoryGirl.create(:group) }
    let(:topic) { Topic.first }

    before do
      group.delegates.create(account: account, permission: 'super')
      @group_topic = topic.group_topics.create(group: group)
      sign_in!(account)
    end

    describe "GET /api/v1/groups/:group_id/topics/:topic_id/posts/index" do
      before do
        xhr :get, :index, id_params
      end

      it "200 OK" do
        #expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has posts" do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:posts)).to eq(true)
      end
    end


    describe "GET /api/v1/groups/:group_id/topics/:topic_id/posts/new" do
      before do
        xhr :get, :new, id_params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end


    describe "POST /api/v1/groups/:group_id/topics/:topic_id/posts" do
      before do
        @params = id_params.merge({
          post: FactoryGirl.attributes_for(:draft_post)
        })
      end

      it "200 OK" do
        xhr :post, :create, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it "increase posts" do
        expect do
          xhr :post, :create, @params
        end.to change { @group_topic.posts.count }.by(1)
      end
    end


    describe "GET /api/v1/groups/:group_id/topics/:topic_id/edit" do
      before do
        post = create_post

        xhr :get, :edit, id_params.merge({ id: post.id })
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:body)).to eq(true)
        expect(body.include?(:is_draft)).to eq(true)
      end
    end


    describe "PUT /api/v1/groups/:group_id/topics/:topic_id/posts/:id" do
      before do
        post = create_post

        @params = id_params.merge({
          post: FactoryGirl.attributes_for(:post),
          id: post.id
        })
      end

      it "200 OK" do
        xhr :put, :update, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "increase posts" do
        expect do
          xhr :put, :update, @params
        end.to change { @group_topic.posts.published.count }.by(1)
      end
    end


    describe "DELETE /api/v1/groups/:group_id/topics/:topic_id/posts" do
      before do
        post = create_post

        @params = id_params.merge({
          id: post.id
        })
      end

      it "200 OK" do
        xhr :delete, :destroy, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "increase posts" do
        expect do
          xhr :delete, :destroy, @params
        end.to change { @group_topic.posts.count }.by(-1)
      end
    end


    def create_post
      post = @group_topic.posts.create(
        body: "new-body",
        author: account,
        is_draft: true
      )
      post
    end

    def id_params
      {
        group_id: group.id,
        topic_id: topic.id
      }
    end
  end
end
