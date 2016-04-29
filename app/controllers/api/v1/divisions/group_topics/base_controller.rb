module Api::V1::Divisions
  class GroupTopics::BaseController < Api::V1::Divisions::BaseController

    before_action :group_topic
    before_action :group
    before_action :category

    def group_topic
      unless @group_topic
        id = params[:group_topic_id] || params[:id]
        @group_topic = GroupTopic.find(id)
      end

      ActiveRecord::RecordNotFound unless @group_topic
      @group_topic
    end

    def group
      unless @group
        @group = @group_topic.group
      end

      ActiveRecord::RecordNotFound unless @group
      @group
    end

    def category
      unless @category
        @category = @group.category_name
      end

      ActiveRecord::RecordNotFound unless @category
      @category
    end
  end
end
