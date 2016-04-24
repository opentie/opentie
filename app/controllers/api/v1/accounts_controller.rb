module Api::V1
  class AccountsController < Api::V1::BaseController

    before_action :authenticate_account!, only: [:edit, :update, :show]

    def show
      groups = current_account.groups
      divisions = current_account.divisions

      render_ok(
        current_account.attributes.merge({
          groups: groups,
          divisions: divisions
        })
      )
    end

    def new
      # return schema from mongodb
      # FIXME
      render_ok({ result: true })
    end

    def create
      account = Account.create_with_kibokan(account_params)

      email = params[:kibokan][:email]
      RegisterEmailService.new(account).execute(email)

      render_ok
    end

    def edit
      current_account
      # return schema from mongodb
      # FIXME
      render_ok
    end

    def email_confirm
      token = params[:email_set_token]
      account = EmailRecoveryToken.find_by!(token: token).account

      UpdateEmailService.new(account).execute(token)

      sign_in!(account)
      render_ok
    end

    def update
      email = params[:kibokan][:email]

      if email != current_account.email
        RegisterEmailService.new(current_account).execute(email)
      end

      params[:email] = current_account.email
      current_account.update_with_kibokan(params[:kibokan])

      render_ok
    end

    private

    def account_params
      params.require(:account).permit(
        :password, :password_confirmation
      ).merge(
        params[:kibokan]
      )
    end
  end
end
