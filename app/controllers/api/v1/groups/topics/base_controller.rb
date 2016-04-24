module Api::V1::Groups
  class Topics::BaseController < Api::V1::Groups::BaseController

    before_action :topic
    before_action :group_topic

    def topic
      unless @topic
        id = params[:topic_id] || params[:id]
        @topic = @group.topics.includes(
          :group_topics,
          group_topics: [:posts, :tags]
        ).find(id)
      end

      ActiveRecord::RecordNotFound unless @topic
      @topic
    end

    def group_topic
      unless @group_topic
        id = params[:topic_id] || params[:id]
        @group_topic = @group.group_topics.includes(
          :posts, :tags, :topic
        ).find_by(topic_id: @topic.id)
      end

      ActiveRecord::RecordNotFound unless @group_topic
      @group_topic
    end
  end
end
