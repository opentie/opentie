module Api::V1::Divisions
  class GroupTopicsController < Api::V1::Divisions::GroupTopics::BaseController

    before_action :load_topic_detail

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

    def load_topic_detail
      @topic = @group_topic.topic
      @tags = @group_topic.tag_list
      @posts = @group_topic.posts
    end
  end
end
