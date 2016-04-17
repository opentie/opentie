module Api::V1
  class DivisionsController < Api::V1::Divisions::BaseController

    before_action :authenticate_account!
    before_action :authenticate_admin!,  only: [:new, :create]
    before_action :load_division,        only: [:show, :invitation]

    def new
      render_ok
    end

    def create
      name = params[:name]
      Division.create_with_name(name)

      render_ok
    end

    def invitation
      email = params[:email]

      # invite

      render_ok
    end

    def show
      render json: {
        division: @division.attributes,
        member: @member.map{|m| m.attributes}
      }
    end

    private

    def authenticate_admin!
      render_unauthorized unless current_account.is_admin
    end

    def load_division
      @division = Division.find_by!(id: params[:id])
      @member = @division.accounts
    end
  end
end
