require 'rails_helper'

module Api::V1
  RSpec.describe DivisionsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:admin) { FactoryGirl.create(:admin) }

    describe "GET /api/v1/divisions/new" do
      it "Unauthorized" do
        sign_in!(account)
        xhr :get, :new

        expect(response.status).to eq(401)
      end

      it "200 OK" do
        sign_in!(admin)
        xhr :get, :new

        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/create" do
      it "Unauthorized" do
        sign_in!(account)
        xhr :post, :create

        expect(response.status).to eq(401)
      end

      it "200 OK" do
        sign_in!(admin)
        xhr :post, :create, division_params

        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/divisions/invitation" do
      pending "not impliment yet"
    end

    describe "GET /api/v1/divisions/new" do
      before do
        sign_in!(account)
        xhr :get, :show, { id: Division.first.id }
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:members)).to eq(true)
      end
    end

    def division_params
      {
        division: FactoryGirl.attributes_for(:division),
        default_account_email: account.email
      }
    end
  end
end
