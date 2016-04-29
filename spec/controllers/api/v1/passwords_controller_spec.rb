require 'rails_helper'

module Api::V1
  RSpec.describe PasswordsController, type: :controller do
    let(:account) { FactoryGirl.create(:account) }
    let(:email) { account.email }

    describe "POST /api/v1/passwords/" do
      before do
        @params = { email: email }
      end

      it "200 OK" do
        xhr :post, :create, @params
        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it "increse password_recovery_tokens" do
        expect do
          xhr :post, :create, @params
        end.to change { PasswordRecoveryToken.all.count }.by(1)
      end

      it "increse sended email" do
        expect do
          xhr :post, :create, @params
        end.to change { ActionMailer::Base.deliveries.size }.by(1)
      end
    end

    describe "Update new password" do
      before do
        sign_in!(account)
        PasswordRecoveryToken.create_new_token(account)
      end

      it "change password by correct confirmation" do
        xhr :put, :update, valid_params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "can't change password by wrong confirmation" do
        xhr :put, :update, invalid_params
        expect(response.status).to eq(400)
      end

      it "decrese password_recovery_tokens" do
        expect do
          xhr :put, :update, valid_params
        end.to change { PasswordRecoveryToken.all.count }.by(-1)
      end

      it "can't login old password" do
        xhr :put, :update, invalid_params
        expect(account.authenticate('new_password')).to eq(false)
      end

      it "can login new password" do
        xhr :put, :update, valid_params
        expect(account.authenticate('new_password')).to eq(false)
      end
    end

    def valid_params
      {
        password: "new_password",
        password_confirmation: "new_password",
        password_reset_token: account.password_recovery_tokens.first.token
      }
    end

    def invalid_params
      {
        password: "new_password",
        password_confirmation: "wrong_password",
        password_reset_token: account.password_recovery_tokens.first.token
      }
    end
  end
end
