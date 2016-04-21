module Api::V1::Divisions
  class TopicsController < Api::V1::Divisions::BaseController

    #before_action :division
    before_action :topic, except: [:new, :create, :index]

    def index
      topics = Topic.published.all

      render_ok({
        topics: topics
      })
    end

    def show
      group_params = @topic.group_topics.map do |gt|
        # link用
        gt.group.attributes.merge({group_topic_id: gt.id})
      end

      render_ok({
        topic: @topic,
        groups: group_params
      })
    end

    def new
      render_ok
    end

    def create
      CreateTopicService.
        new(@division, current_account).
        execute(project_params)

      render_ok
    end

    def edit
      render_ok({
        topic: @topic,
      })
    end

    def update
      UpdateUpdateService.
        new(@topic).
        execute(project_params)

      render_ok
    end

    def destroy
      @topic.destroy

      render_ok
    end

    private

    def topic
      unless @topic
        id = params[:topic_id] || params[:id]

        # caching here
        @topic =
          Topic.includes(
          :groups,
          :group_topics,
          group_topics: [:posts, :labels]
        ).find(id)
      end

      render_not_found unless @topic
      @topic
    end

    def project_params
      params.require(:topic).permit(
        :title, :description, :is_draft
      ).merge({
        group_ids: params[:group_ids],
        tag_list: params[:tag_list]
      })
    end
  end
end
