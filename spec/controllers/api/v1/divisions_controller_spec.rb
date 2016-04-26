require 'rails_helper'

module Api::V1
  RSpec.describe DivisionsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:admin) { FactoryGirl.create(:admin) }
    let(:division) { FactoryGirl.create(:division) }

    before do
      division.roles.create(account: account, permission: 'super')
    end

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
        expect(response.status).to eq(201)
      end
    end

    describe "POST /api/v1/divisions/invite" do
      before do
        @account_param = {
          id: division.id,
          invite_account: {
            email: "invite@opentie.com",
            permission: 'normal'
          }
        }

        @yet_account_param = {
          id: division.id,
          invite_account: {
            email: account.email,
            permission: 'normal'
          }
        }
      end

      it "200 OK, with send email" do
        sign_in!(account)
        xhr :post, :invite, @yet_account_param

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "200 OK, with send email" do
        sign_in!(account)
        xhr :post, :invite, @account_param

        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "GET /api/v1/divisions/:id" do
      before do
        sign_in!(account)

        xhr :get, :show, { id: division.id }
      end

      it "200 OK" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "has attributes" do
        body = JSON.parse(response.body).deep_symbolize_keys
        expect(body.include?(:members)).to eq(true)
        expect(body[:members][0].include?(:permission)).to eq(true)
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
