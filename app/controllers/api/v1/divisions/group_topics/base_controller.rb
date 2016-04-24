module Api::V1::Divisions
  class GroupTopics::BaseController < Api::V1::Divisions::BaseController

    before_action :group_topic

    def group_topic
      unless @group_topic
        id = params[:group_topic_id] || params[:id]
        @group_topic = GroupTopic.find(id)
      end

      ActiveRecord::RecordNotFound unless @group_topic
      @group_topic
    end
  end
end
