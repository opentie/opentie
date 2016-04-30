require 'rails_helper'

module Api::V1
  RSpec.describe InformationController, type: :controller do
    describe 'GET api/v1/information' do
      before do
        xhr :get, :show
      end

      it '200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'return application data' do
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body.include?(:service_name)).to eq(true)
        expect(body.include?(:organization_name)).to eq(true)
        expect(body.include?(:organization_mail)).to eq(true)
        expect(body.include?(:organization_tel)).to eq(true)
      end
    end
  end
end
