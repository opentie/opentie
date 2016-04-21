module Api::V1::Divisions
  class GroupTopics::BaseController < Api::V1::Divisions::BaseController

    def group_topic
      unless @group_topic
        id = params[:group_topic_id] || params[:id]
        @group_topic = GroupTopic.find(id)
      end

      render_not_found unless @group_topic
      @group_topic
    end

    def tag
      @tags = @group_topic.tag_list
    end

    def post
      @posts = @group_topic.posts.order(:sended_at)
    end
  end
end
