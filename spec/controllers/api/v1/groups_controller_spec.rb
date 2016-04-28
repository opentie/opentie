require 'rails_helper'

module Api::V1
  RSpec.describe GroupsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:group) { FactoryGirl.create(:group) }

    describe "GET /api/v1/groups/new" do
      before do
        params = {
          category_name: "name"
        }
        xhr :get, :new, params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:form)).to eq(true)
      end
    end

    describe "POST /api/v1/groups/" do
      before do
        @params = {
          kibokan: {},
          category_name: "category_name",
          group: FactoryGirl.attributes_for(:group)
        }
      end

      it '201 OK' do
        xhr :post, :create, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    describe "GET /api/v1/groups/edit" do
      before do
        Delegate.create(group: group, account: account)
        sign_in!(account)
        params = {
          id: group.id,
        }
        xhr :get, :edit, params
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
        Delegate.create(group: group, account: account)
        sign_in!(account)
        params = {
          id: group.id,
          category_name: "category_name",
          group: FactoryGirl.attributes_for(:group)
        }
        xhr :put, :update, params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/groups/:id" do
      before do
        Delegate.create(group: group, account: account)
        sign_in!(account)
        params = {
          id: group.id,
          category_name: "category_name",
          kibokan: {}
        }
        xhr :get, :show, params
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
  end
end
