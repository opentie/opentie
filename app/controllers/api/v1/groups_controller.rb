module Api::V1
  class GroupsController < Api::V1::Groups::BaseController

    before_action :group, except: [:new, :create]
    before_action :delegate, except: [:new, :create]

    def new
      entity_body = Group.get_init_entity_body(@category.name)

      render_ok({
        entity: entity_body
      })
    end

    def create
      group = Group.create_with_kibokan(current_account, group_params)
      entity = group.get_entity

      render_created(
        group.attributes.merge({
          kibokan: entity.payload
        })
      )
    end

    def edit
      entity = @group.get_entity

      render_ok(
        group.attributes.merge({
          kibokan: entity.payload
        })
      )
    end

    def invite
      render_unauthorized and return unless @delegate.super?

      email = invite_params[:email]
      permission = invite_params[:permission]

      InviteAccountService.new(@group).execute(email, permission)

      render_ok
    end

    def update
      @group.update_with_kibokan(group_params)

      render_ok
    end

    def show
      entity = @group.get_entity

      render_ok(
        @group.attributes.merge({
          kibokan: entity.payload
        })
      )
    end

    private

    def invite_params
      params.require(:invite).permit(
        :email, :permission
      )
    end

    def group_params
      params.require(:group).permit(
        :kibokan_id
      ).merge({
        category_name: @category.name,
        kibokan: params[:kibokan].except(:metadata)
      })
    end
  end
end
