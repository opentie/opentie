module Api::V1::Divisions
  class Topics::BaseController < Api::V1::Divisions::BaseController

    def topic
      unless @topic
        id = params[:topic_id] || params[:id]

        # caching here
        @topic =
          Topic.includes(
          :groups,
          :group_topics,
          group_topics: [:posts, :labels]
        ).find!(id)
      end

      @topic
    end
  end
end
