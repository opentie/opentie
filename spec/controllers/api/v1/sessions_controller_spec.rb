require 'rails_helper'

module Api::V1
  RSpec.describe SessionsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }

    describe "Sign in" do
      before do
        @params = sign_in_params
      end

      it "Success sign_in" do
        xhr :post, :sign_in, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it "Wrong email" do
        @params[:email] = 'wrong@opentie.com'
        xhr :post, :sign_in, @params
        expect(response.status).to eq(401)
      end

      it "Wrong password" do
        @params[:password] = 'wrongpassword'
        xhr :post, :sign_in, @params
        expect(response.status).to eq(401)
      end
    end

    describe "Sign out" do
      before do
        sign_in!(account)
        xhr :post, :sign_out
      end

      it "Success sign_out" do
        expect(response).to be_success
        expect(response.status).to eq(201)
      end
    end

    def sign_in_params
      {
        email: account.email,
        password: FactoryGirl.attributes_for(:account)[:password]
      }
    end
  end
end
