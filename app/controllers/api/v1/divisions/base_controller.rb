module Api::V1
  class Divisions::BaseController < Api::V1::BaseController

    # before_action :authenticate_account!

    before_action :account

    def division
      unless @division
        id = params[:division_id] || params[:id]
        @division = Division.find(id)
      end

      render_not_found unless @division
      @division
    end

    def account
      #unless @account
      #  id = params[:account_id] || params[:id]
      #  @account = Account.find(id)
      #end

      @account = Account.first unless @account
      @account
    end
  end
end
