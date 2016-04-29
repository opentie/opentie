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

    describe "index" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').index
        expect(res).to eq(@responses)
      end
    end

    describe "show" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').show
        expect(res).to eq(@response)
      end
    end

    describe "new" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').new
        expect(res).to eq(@response)
      end
    end

    describe "create" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').create({})
        expect(res).to eq(@response)
      end
    end

    describe "update" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').update({})
        expect(res).to eq(@response)
      end
    end

    describe "bulk" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').bulk([])
        expect(res).to eq(@responses)
      end
    end

    describe "where" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').where('query')
        expect(res).to eq(@responses)
      end
    end
  end
end
