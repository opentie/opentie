require 'rails_helper'
require 'api/v1/sessions_controller'

RSpec.describe Api::V1::AccountsController, type: :controller do
  describe "GET /api/v1/account" do
    before do
      xhr :get, :new
    end

    it '200 OK' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

  end

  describe "GET /api/v1/account/edit" do
    before do
      account = FactoryGirl.create(:account)
      sign_in!(account)
    end

    it '200 OK' do
      xhr :get, :edit
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/v1/account" do
    before do
      @attributes = FactoryGirl.attributes_for(:account)
      @attributes.merge!({ kibokan: { email: "opentie@example.com" } })
    end

    it '200 OK' do
      xhr :post, :create, @attributes

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'increse column of account' do
      expect do
        xhr :post, :create, @attributes
      end.to change { Account.all.count }.by(1)
    end

    it 'send email confirm mail' do
      expect do
        xhr :post, :create, @attributes
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'increse column of email_recovery_tokens' do
      expect do
        xhr :post, :create, @attributes
      end.to change { EmailRecoveryToken.all.count }.by(1)
    end
  end

  describe "POST /api/v1/account/email_confirm" do
    before do
      @account = FactoryGirl.create(:account)
      @new_email = "changed-opentie@example.com"
      @recovery_token =
        EmailRecoveryToken.create_new_token(@account, @new_email)
    end

    it '200 OK' do
      xhr :post, :email_confirm, email_set_token: @recovery_token.token
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'change email' do
      expect do
        xhr :post, :email_confirm, email_set_token: @recovery_token.token
      end.to change { Account.where(email: @new_email).count }.from(0).to(1)
    end

    it 'increse and decrese column of email_recovery_tokens' do
      expect do
        xhr :post, :email_confirm, email_set_token: @recovery_token.token
      end.to change { EmailRecoveryToken.all.count }.by(-1)
    end

    it 'login?' do
      xhr :post, :email_confirm, email_set_token: @recovery_token.token
      expect(current_account).to eq(@account)
    end
  end

  describe "PUT /api/v1/account" do
    before do
      account = FactoryGirl.create(:account)
      sign_in!(account)

      @params = { email: "changed-opentie@example.com"}
    end

    it '200 OK' do
      xhr :put, :update, @params
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'increse and decrese column of email_recovery_tokens' do
      expect do
        xhr :put, :update, @params
      end.to change { EmailRecoveryToken.all.count }.by(1)
    end
  end
end
