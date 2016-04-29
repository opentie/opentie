module Api::V1
  class Groups::BaseController < Api::V1::BaseController

    before_action :authenticate_account!
    before_action :group
    before_action :delegate
    before_action :category

    def group
      unless @group
        id = params[:group_id] || params[:id]
        @group = current_account.groups.find(id)
      end

      ActiveRecord::RecordNotFound unless @group
      @group
    end

    def delegate
      unless @delegate
        @delegate = @group.delegates.find_by(account: current_account)
      end

      ActiveRecord::RecordNotFound unless @delegate
      @delegate
    end

    def category
      unless @category
        unless @group
          name = params[:category_name]
          @category = Category.new(
            name: name,
            namespace: Group.current_namespace
          )
        else
          @category = Category.new(
            name: @group.name,
            namespace: Group.current_namespace
          )
        end
      end

      ActiveRecord::RecordNotFound unless @category
      @category
    end
  end
end
