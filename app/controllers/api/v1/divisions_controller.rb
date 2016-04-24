module Api::V1
  class DivisionsController < Api::V1::Divisions::BaseController

    before_action :authenticate_account!
    before_action :authenticate_admin!,  only: [:new, :create]
    before_action :division, only: [:show, :invitation]

    def new
      render_ok
    end

    def create
      account_email = params[:default_account_email]
      CreateDivisionService.new(account_email).execute(division_params)

      render_ok
    end

    def invitation
      email = params[:email]

      # TODO

      render_ok
    end

    def show
      members = @division.accounts
      render_ok(@division.attributes.merge({ members: members }))
    end

    private

    def division_params
      params.require(:division).permit(:name)
    end

    def authenticate_admin!
      render_unauthorized unless current_account.is_admin
    end
  end
end
