require 'rails_helper'

module Api::V1::Divisions::GroupTopics
  RSpec.describe PostsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }
    let(:group) { FactoryGirl.create(:group) }
    let(:topic) { Topic.first }

    before do
      group.delegates.create(account: account, permission: 'normal')
      division.roles.create(account: account, permission: 'normal')
      @group_topic = topic.group_topics.create(group: group)
      sign_in!(account)
    end

    describe "GET /divisions/:division_id/group_topics/:group_topic_id/posts" do
      before do
        xhr :get, :index, id_params
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
        xhr :get, :new, id_params
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end


    describe "POST /divisions/:division_id/group_topics/:group_topic_id/posts" do
      before do
        params = { post: FactoryGirl.attributes_for(:post) }
        xhr :post, :create, id_params.merge(params)
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end


    describe "GET /divisions/:division_id/group_topics/:group_topic_id/posts/edit/:id" do
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
      end
    end


    describe "PUT /divisions/:division_id/group_topics/:group_topic_id/posts/:id" do
      before do
        post = create_post

        params = {
          post: FactoryGirl.attributes_for(:post),
          id: post.id
        }

        xhr :put, :update, id_params.merge(params)
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "DELETE /divisions/:division_id/group_topics/:group_topic_id/posts/:id" do
      before do
        post = create_post

        params = {
          post: FactoryGirl.attributes_for(:post),
          id: post.id
        }

        xhr :delete, :destroy, id_params.merge(params)
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    def id_params
      {
        division_id: division.id,
        group_topic_id: @group_topic.id
      }
    end

    def create_post
      post = @group_topic.posts.create(
        body: "new-body",
        author: account,
        is_draft: true,
        division: division
      )
      post
    end
  end
end
