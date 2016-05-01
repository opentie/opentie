module Api::V1::Divisions
  class GroupsController < Api::V1::Divisions::Groups::BaseController

    before_action :group

    def show
      entity_payload = @group.get_entity.payload
      accounts = @group.accounts.includes(:delegates)

      members = accounts.map do |a|
        permission = a.delegates.find_by(group: @group).permission
        entity = a.get_entity
        {
          id: a.id,
          email: a.email,
          kibokan: entity.payload,
          permission: permission
        }
      end

      render_ok({
        id: @group.id,
        kibokan: entity_payload,
        members: members
      })
    end

    def edit
      entity_payload = @group.get_entity.payload
      accounts = @group.accounts.includes(:delegates)

      members = accounts.map do |a|
        permission = a.delegates.find_by(group: @group).permission
        entity = a.get_entity
        {
          id: a.id,
          email: a.email,
          kibokan: entity.payload,
          permission: permission
        }
      end

      render_ok({
        id: @group.id,
        kibokan: entity_payload,
        members: members
      })
    end

    def update
      @group.update_with_kibokan(group_params)

      render_ok
    end

    private

    def group_params
      params.require(:group).permit(
        :is_froze
      ).merge({
        kibokan: params[:kibokan]
      })
    end
  end
end
