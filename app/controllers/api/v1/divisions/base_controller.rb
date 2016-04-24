module Api::V1
  class Divisions::BaseController < Api::V1::BaseController

    before_action :authenticate_account!
    before_action :division

    def division
      unless @division
        id = params[:division_id] || params[:id]
        @division = Division.find(id)
      end

      ActiveRecord::RecordNotFound unless @division
      @division
    end
  end
end
