require 'rails_helper'

module Kibokan
  RSpec.describe Agent do
    before do
      @response = {
        _id: 'idididiid',
        _name: 'namenamename',
        payload: { data: 'data' }
      }
    end

    describe "initialize" do
      it "created" do
        agent = Agent.new('/sample/test')
        expect(agent).not_to eq(nil)
      end
    end

    describe "get" do
      it "response is accept" do
        res = Agent.new('/sample/test').get
        expect(res).to eq(@response)
      end
    end

    describe "post" do
      it "response is accept" do
        res = Agent.new('/sample/test').post({})
        expect(res).to eq(@response)
      end
    end

    describe "get" do
      it "response is accept" do
        res = Agent.new('/sample/test').put({})
        expect(res).to eq(@response)
      end
    end

    describe "get" do
      it "response is accept" do
        res = Agent.new('/sample/test').bulk
        expect(res).to eq(@response)
      end
    end

    describe "get" do
      it "response is accept" do
        res = Agent.new('/sample/test').search('query')
        expect(res).to eq(@response)
      end
    end
  end
end
