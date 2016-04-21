module Api::V1::Divisions
  class GroupTopicsController < Api::V1::Divisions::GroupTopics::BaseController

    before_action :tag
    before_action :post
    before_action :topic
    prepend_before_action :group_topic

    def show
      render_ok({
        group_topic: {
          topic: @topic,
          tags: @tags,
          posts: @posts
        }
      })
    end

    private

    def topic
      unless @topic
        @topic = @group_topic.topic
      end
      @topic
    end
  end
end
