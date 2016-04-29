module Api::V1
  class AccountsController < Api::V1::BaseController

    before_action :authenticate_account!, only: [:edit, :update, :show]

    def show
      divisions = current_account.divisions
      local_groups = current_account.groups.group_by {|g| g.current_category }

      kibokan_groups = local_groups.map do |category, groups|
        kibokan_ids = cat_groups.map {|g| g.kibokan_id }
        entities = Group.get_entities(category, kibokan_ids)
        { category => entities }
      end

      render_ok({
        account: current_account.attributes.merge({
          entity: current_account.get_entity,
          groups: kibokan_groups,
          divisions: divisions
        })
      })
    end

    def new
      entity_body = Account.get_init_entity_body('accounts')

      render_ok({
        entity: entity_body
      })
    end

    def create
      account = Account.create_with_kibokan(account_params)

      email = params[:account][:email]
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
      current_account.update_with_kibokan(account_params)

      if email != current_account.email
        RegisterEmailService.new(current_account).execute(email)
      end

      render_ok
    end

    private

    def account_params
      params.require(:account).permit(
        :password, :password_confirmation
      ).merge({
        kibokan: params[:kibokan]
      })
    end
  end
end
