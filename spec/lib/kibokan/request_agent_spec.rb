require 'rails_helper'

module Kibokan
  RSpec.describe RequestAgent do
    describe "initialize" do
      it "created" do
        agent = RequestAgent.new('/sample/test')
        expect(agent).not_to eq(nil)
      end
    end

    describe "index" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').index
        expect(res.class).to eq(Array)
      end
    end

    describe "show" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').show
        expect(res.class).to eq(Hash)
      end
    end

    describe "new" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').new
        expect(res.class).to eq(Hash)
      end
    end

    describe "create" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').create({})
        expect(res.class).to eq(Hash)
      end
    end

    describe "update" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').update({})
        expect(res.class).to eq(Hash)
      end
    end

    describe "bulk" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').bulk({ids: ['id']})
        expect(res.class).to eq(Array)
      end
    end

    describe "where" do
      it "response is accept" do
        res = RequestAgent.new('/sample/test').where('query')
        expect(res.class).to eq(Array)
      end
    end
  end
end
