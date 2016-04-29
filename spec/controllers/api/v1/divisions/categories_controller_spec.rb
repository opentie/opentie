require 'rails_helper'

module Api::V1::Divisions::Categories
  RSpec.describe CategoriesController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:division) { FactoryGirl.create(:division) }

    before do
      division.roles.create(account: account)
      sign_in!(account)
    end

    describe 'GET /api/v1/divisions/:division_id/categories/' do
      before do
        xhr :get, :index, default_params
      end


      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:categories)).to eq(true)
      end
    end

    describe 'GET /api/v1/divisions/:division_id/categories/:id' do
      before do
        xhr :get, :show, category_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:category)).to eq(true)
      end
    end

    describe 'GET /api/v1/divisions/:division_id/categories/new' do
      before do
        xhr :get, :new, category_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe 'POST /api/v1/divisions/:division_id/categories/' do
      before do
        xhr :post, :create, store_params
      end

      it '201 Created' do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    describe 'GET /api/v1/divisions/:division_id/categories/edit' do
      before do
        xhr :get, :edit, category_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:category)).to eq(true)
      end
    end

    describe 'PUT /api/v1/divisions/:division_id/categories/:id' do
      before do
        xhr :put, :update, store_params.merge(category_params)
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
        kibokan: {}
      })
    end

    def category_params
      default_params.merge({
        name: 'category_name'
      })
    end
  end
end
