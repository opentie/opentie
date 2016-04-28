module Api::V1
  class GroupsController < Api::V1::Groups::BaseController

    before_action :authenticate_account!, only: [:show]
    before_action :group,     except: [:new, :create]
    before_action :category,  except: [:new, :create]

    def new
      category_name = params[:category_name]
      form = Group.get_root_form(category_name)

      render_ok({
        form: form
      })
    end

    def create
      Group.create_with_kibokan(group_params)

      render_created
    end

    def edit
      entity = @group.get_entity

      render_ok({
        group: group.attributes.merge(entity.attributes)
      })
    end

    def update
      @group.update_with_kibokan(group_params)

      render_ok
    end

    def show
      entity = @group.get_entity

      render_ok({
        group: @group.attributes.merge(entity.attributes)
      })
    end

    private

    def group_params
      params.require(:group).permit(
        :kibokan
      ).merge({
        category_name: params[:category_name]
      })
    end
  end
end
