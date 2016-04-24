module Api::V1
  class Groups::BaseController < Api::V1::BaseController

    before_action :authenticate_account!
    before_action :group

    def group
      unless @group
        id = params[:group_id] || params[:id]
        @group = current_account.groups.find(id)
      end

      ActiveRecord::RecordNotFound unless @group
      @group
    end
  end
end
