module Api::V1::Divisions
  class TopicsController < Api::V1::Divisions::Topics::BaseController

    before_action :division
    before_action :tag,           except: [:new, :create, :index]
    before_action :post,          except: [:new, :create, :index]
    prepend_before_action :topic, except: [:new, :create, :index]

    def index
      topics = Topic.published.all

      render_ok({
        topics: topics
      })
    end

    def show
      render_ok({
        topic: @topic,
        tags: @tags,
        posts: @posts
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
        tags: @tags,
        posts: @posts
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

    def tag
      topic unless @topic

      @tags = @topic.group_topics.map do |gt|
        [ gt.group_id, gt.tag_list ]
      end.to_h
    end

    def post
      topic unless @topic

      @posts = @topic.group_topics.map do |gt|
        [ gt.group_id, gt.posts ]
      end.to_h
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
