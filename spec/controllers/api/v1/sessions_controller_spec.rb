require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "Sign in" do
    before do
      FactoryGirl.create(:account)
      @params = FactoryGirl.attributes_for(:account).slice(:email, :password)

      xhr :post, :sign_in, @params
    end

    it "Success sign_in" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "Sign out" do
    before do
      FactoryGirl.create(:account)
      @params = FactoryGirl.attributes_for(:account).slice(:email, :password)

      xhr :post, :sign_in, @params
    end

    it "Success sign_in" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "Success sign_out" do
      xhr :post, :sign_out, {}

      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

end
