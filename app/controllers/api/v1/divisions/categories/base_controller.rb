module Api::V1::Divisions
  class Categories::BaseController < Api::V1::Divisions::BaseController

    before_action :category

    def category
      unless @category
        @category = Category.new(
          namespace: Group.current_namespace,
          name: params[:category_name] || params[:name]
        )
      end

      ActiveRecord::RecordNotFound unless @category
      @category
    end
  end
end
