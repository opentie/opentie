require 'rails_helper'

module Kibokan
  RSpec.describe RequestAgent do
    before do
      @responses = [{
        _id: 'idididiid',
        _name: 'namenamename',
        payload: { data: 'data' }
      }]

      @response = {
        _id: 'idididiid',
        _name: 'namenamename',
        payload: { data: 'data' }
      }
    end

    describe "initialize" do
      it "created" do
        agent = RequestAgent.new('/sample/test')
        expect(agent).not_to eq(nil)
      end
    end

    describe "get" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').get
        expect(res).to eq(@responses)
      end
    end

    describe "new" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').new
        expect(res).to eq(@response)
      end
    end

    describe "post" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').post({})
        expect(res).to eq(@response)
      end
    end

    describe "put" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').put({})
        expect(res).to eq(@response)
      end
    end

    describe "bulk" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').bulk([])
        expect(res).to eq(@responses)
      end
    end

    describe "search" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').search('query')
        expect(res).to eq(@responses)
      end
    end
  end
end
