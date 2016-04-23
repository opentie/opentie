require 'rails_helper'

RSpec.describe CreateDivisionService, type: :services do
  let(:account) { FactoryGirl.create(:account) }

  describe "execute" do
    it "create division" do
      expect do
        create_division
      end.to change { account.divisions.count }.by(1)
    end

    it "role is super" do
      division = create_division
      expect(
        Role.where(account: account, division: division).first.super?
      ).to eq(true)
    end
  end

  def create_division
    CreateDivisionService.new(account).execute({
      name: "division_name"
    })
  end
end
