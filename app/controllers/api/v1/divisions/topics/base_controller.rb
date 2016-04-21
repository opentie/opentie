module Api::V1::Divisions
  class Topics::BaseController < Api::V1::Divisions::BaseController

    def topic
      unless @topic
        id = params[:topic_id] || params[:id]
        @topic = Topic.find!(id)
      end

      @topic
    end
  end
end
