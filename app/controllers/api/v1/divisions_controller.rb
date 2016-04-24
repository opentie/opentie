module Api::V1
  class DivisionsController < Api::V1::Divisions::BaseController

    before_action :authenticate_admin!, only: [:new, :create]
    before_action :division, only: [:show, :invite]
    before_action :role, only: [:show, :invite]

    def new
      render_ok
    end

    def create
      account_email = params[:default_account_email]
      CreateDivisionService.new(account_email).execute(division_params)

      render_ok
    end

    def invite
      render_unauthorized and return unless @role.super?

      email = params[:invite_account][:email]
      permission = params[:invite_account][:permission]

      InviteDivisionAccountService.new(@division).execute(email, permission)

      render_ok
    end

    def show
      members = @division.accounts.joins(:roles).select(:email, 'roles.permission')
      render_ok(@division.attributes.merge({ members: members }))
    end

    private

    def division_params
      params.require(:division).permit(:name)
    end
  end
end
