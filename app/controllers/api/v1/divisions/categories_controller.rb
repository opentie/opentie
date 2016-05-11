module Api::V1::Divisions
  class CategoriesController < Api::V1::Divisions::Categories::BaseController

    before_action :category, except: [:index, :new, :create]

    def index
      categories = Category.all(Group.current_namespace).map do |category|
        category.payload
      end

      render_ok({
        categories: categories
      })
    end

    def show
      render_ok({
        category: @category.payload
      })
    end

    def new
      render_ok
    end

    def create
      Category.create(Group.current_namespace, params)
      render_created
    end

    def edit
      render_ok({
        category: @category.payload
      })
    end

    def update
      @category.update(category_params)
      render_ok
    end

    private

    def category_params
      params.permit(
        :kibokan
      )
    end
  end
end
