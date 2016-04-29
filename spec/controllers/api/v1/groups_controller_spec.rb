require 'rails_helper'

module Api::V1
  RSpec.describe GroupsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:group) { FactoryGirl.create(:group) }

    describe "GET /api/v1/groups/new" do
      before do
        xhr :get, :new, default_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:entity)).to eq(true)
      end
    end

    describe "POST /api/v1/groups/" do
      before do
        @params = store_params
      end

      it '201 OK' do
        xhr :post, :create, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    describe "POST /api/v1/groups/invite" do
      before do
        sign_in!(account)

        @params = group_params.merge({
          invite: {
            email: "invite@opentie.co",
            permission: "normal"
          }
        })

        account.delegates.find_by(group: group).update(permission: 'super')
      end

      it '200 OK' do
        xhr :post, :invite, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'yet register email' do
        xhr :post, :invite, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'already register email' do
        @params[:invite][:email] = Account.first.email
        xhr :post, :invite, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/groups/edit" do
      before do
        sign_in!(account)
        xhr :get, :edit, group_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:group)).to eq(true)
      end
    end

    describe "PUT /api/v1/groups/:id" do
      before do
        sign_in!(account)

        xhr :put, :update, store_params.merge(group_params)
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/groups/:id" do
      before do
        sign_in!(account)
        xhr :get, :show, group_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:group)).to eq(true)
      end
    end

    def default_params
      {
        category_name: 'category_name'
      }
    end

    def store_params
      default_params.merge({
        kibokan: {},
        group: FactoryGirl.attributes_for(:group)
      })
    end

    def group_params
      Delegate.create(group: group, account: account)
      default_params.merge({ id: group.id })
    end
  end
end
