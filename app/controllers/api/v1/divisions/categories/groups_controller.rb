module Api::V1::Divisions::Categories
  class GroupsController < Api::V1::Divisions::Categories::BaseController

    before_action :category

    def index
      groups = Group.get_entities(@category.name).map do |entity|
        entity.payload
      end

      render_ok({
        groups: groups
      })
    end
  end
end
