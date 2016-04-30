module Api::V1::Divisions
  class Groups::BaseController < Api::V1::Divisions::BaseController

    before_action :group

    def group
      unless @group
        id = params[:group_id] || params[:id]
        @group = Group.find(id)
      end

      raise ActiveRecord::RecordNotFound unless @group
      @group
    end
  end
end
