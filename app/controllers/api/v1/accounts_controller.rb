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
      forms = Account.get_forms('accounts')

      render_ok({
        forms: forms.map{|f| f.attributes }
      })
    end

    def create
      account = Account.create_with_kibokan(account_params)

      email = params[:kibokan][:email]
      RegisterEmailService.new(account).execute(email)

      render_created
    end

    def edit
      forms = Account.get_forms('accounts')

      entity = Account.get_entities(
        current_account.current_category,
        [current_account.kibokan_id]
      ).first

      render_ok({
        account: current_account.attributes.merge(entity.attributes),
        forms: forms.map{|f| f.attributes }
      })
    end

    def email_confirm
      token = params[:email_set_token]
      account = EmailRecoveryToken.find_by!(token: token).account

      UpdateEmailService.new(account).execute(token)

      sign_in!(account)
      render_created
    end

    def update
      email = params[:account].delete(:email)

      if email != current_account.email
        RegisterEmailService.new(current_account).execute(email)
      end

      current_account.update_with_kibokan(account_params)

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
