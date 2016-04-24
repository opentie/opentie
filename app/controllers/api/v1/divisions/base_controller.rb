module Api::V1
  class Divisions::BaseController < Api::V1::BaseController

    before_action :authenticate_account!
    before_action :division
    before_action :role

    def division
      unless @division
        id = params[:division_id] || params[:id]
        @division = current_account.divisions.includes(
          :roles, :accounts
        ).find(id)
      end

      raise ActiveRecord::RecordNotFound unless @division
      @division
    end

    def role
      unless @role
        @role = @division.roles.find_by(account: current_account)
      end

      raise ActiveRecord::RecordNotFound unless @role
      @role
    end
  end
end
