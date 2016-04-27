module Api::V1
  class AccountsController < Api::V1::BaseController

    before_action :authenticate_account!, only: [:edit, :update, :show]

    def show
      tie_groups = current_account.groups.group_by{|g| g.current_category }
      groups = tie_groups.map do |category, cat_groups|
        kibokan_ids = cat_groups.map {|g| g.kibokan_id }
        {
          category => Group.get_entities(category, kibokan_ids)
        }
      end
      divisions = current_account.divisions

      render_ok({
        account: current_account.attributes.merge({
          entity: current_account.get_entity,
          groups: groups,
          divisions: divisions
        })
      })
    end

    def new
      form = Account.get_root_form('accounts')

      render_ok({
        form: form
      })
    end

    def create
      account = Account.create_with_kibokan(account_params)

      email = params[:kibokan][:email]
      RegisterEmailService.new(account).execute(email)

      render_created
    end

    def edit
      entity = current_account.get_entity

      render_ok({
        account: current_account.attributes.merge(entity.attributes)
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
