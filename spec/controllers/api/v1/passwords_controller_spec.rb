require 'rails_helper'

module Api::V1
  RSpec.describe PasswordsController, type: :controller do

    describe "Create new password" do
      before do
        account = FactoryGirl.create(:account)
        @email = account.email
      end

      it "200 OK" do
        xhr :post, :create, { email: @email }

        expect(response).to be_success
        expect(response.status).to eq(201)
      end

      it "increse password_recovery_tokens" do
        expect do
          xhr :post, :create, { email: @email }
        end.to change { PasswordRecoveryToken.all.count }.by(1)
      end

      it "increse sended email" do
        expect do
          xhr :post, :create, { email: @email }
        end.to change { ActionMailer::Base.deliveries.size }.by(1)
      end
    end

    describe "Update new password" do
      before do
        @account = FactoryGirl.create(:account)
        @attributes = FactoryGirl.attributes_for(:account)
        sign_in!(@account)

        recovery_token = PasswordRecoveryToken.create_new_token(@account)

        @params = {
          password: "new_password",
          password_confirmation: "new_password",
          passwrod_reset_token: recovery_token.token
        }
        @wrong_params = {
          password: "new_password",
          password_confirmation: "new_wrong_password",
          passwrod_reset_token: recovery_token.token
        }
      end

      it "change password by correct confirmation" do
        xhr :put, :update, @params

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "can't change password by wrong confirmation" do
        xhr :put, :update, @wrong_params

        expect(response.status).to eq(400)
      end

      it "decrese password_recovery_tokens" do
        expect do
          xhr :put, :update, @params
        end.to change { PasswordRecoveryToken.all.count }.by(-1)
      end

      it "can't login old password" do
        xhr :put, :update, @params

        account = Account.find(@account.id)

        expect(
          account.authenticate(
            @attributes[:password]
          )
        ).to eq(false)
      end

      it "can login new password" do
        xhr :put, :update, @params

        account = Account.find(@account.id)

        expect(
          account.authenticate(
            @params[:password]
          )
        ).to eq(@account)
      end
    end
  end
end
