require 'rails_helper'

module Api::V1
  RSpec.describe AccountsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }


    describe "GET /api/v1/account/" do
      before do
        sign_in!(account)
        xhr :get, :show
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'has attributes' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:categories)).to eq(true)
        expect(body.include?(:groups)).to eq(true)
        expect(body.include?(:divisions)).to eq(true)
        expect(body.include?(:kibokan)).to eq(true)
        expect(body.include?(:email)).to eq(true)
      end
    end

    describe "GET /api/v1/account/new" do
      before do
        xhr :get, :new
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

    describe "GET /api/v1/account/edit" do
      before do
        sign_in!(account)
        xhr :get, :edit, store_params
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    describe "POST /api/v1/account" do
      before do
        @params = store_params
        @params[:account][:email] = 'new-register@opentie.com'
      end

      it '200 OK' do
        xhr :post, :create, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it 'increse column of account' do
        expect do
          xhr :post, :create, @params
        end.to change { Account.all.count }.by(1)
      end

      it 'send email confirm mail' do
        expect do
          xhr :post, :create, @params
        end.to change { ActionMailer::Base.deliveries.size }.by(1)
      end

      it 'increse column of email_recovery_tokens' do
        expect do
          xhr :post, :create, @params
        end.to change { EmailRecoveryToken.all.count }.by(1)
      end
    end

    describe "POST /api/v1/account/email_confirm" do
      before do
        @new_email = "changed-opentie@example.com"
        @recovery_token =
          EmailRecoveryToken.create_new_token(account, @new_email).token
      end

      it '200 OK' do
        xhr :post, :email_confirm, email_set_token: @recovery_token
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it 'change email' do
        expect do
          xhr :post, :email_confirm, email_set_token: @recovery_token
        end.to change { Account.where(email: @new_email).count }.from(0).to(1)
      end

      it 'increse and decrese column of email_recovery_tokens' do
        expect do
          xhr :post, :email_confirm, email_set_token: @recovery_token
        end.to change { EmailRecoveryToken.all.count }.by(-1)
      end

      it 'login?' do
        xhr :post, :email_confirm, email_set_token: @recovery_token
        expect(current_account).to eq(account)
      end
    end

    describe "PUT /api/v1/account" do
      before do
        sign_in!(account)
        @params = store_params.merge(account_params)
        @params[:account][:email] = 'update@opentie.com'
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

    def default_params
      { }
    end

    def store_params
      default_params.merge({
        kibokan: {},
        account: FactoryGirl.attributes_for(:account)
      })
    end

    def account_params
      default_params.merge({
        id: account.id
      })
    end
  end
end
