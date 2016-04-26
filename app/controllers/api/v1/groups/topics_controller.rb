module Api::V1::Groups
  class TopicsController < Api::V1::Groups::Topics::BaseController

    before_action :topic, except: [:index, :new, :create]
    before_action :group_topic, except: [:index, :new, :create]

    def index
      topics = @group.topics.all
      render_paginate(topics)
    end

    def show
      render_ok({
        topic: @group_topic.topic.attributes.merge({
          posts: @group_topic.posts,
          tags: @group_topic.tag_list
        })
      })
    end

    def new
      render_ok
    end

    def create
      CreateTopicService.
        new(@group, current_account).
        execute(topic_params)

      render_created
    end

    def edit
      render_ok({
        topic: @topic.attributes.merge({
          tags: @group_topic.tag_list
        })
      })
    end

    def update
      UpdateTopicService.
        new(@topic).
        execute(topic_params)

      render_ok
    end

    def destroy
      @topic.destroy
      render_ok
    end

    private

    def topic_params
      params.require(:topic).permit(
        :title, :description, :is_draft
      ).merge({
        group_ids: [@group.id],
        tag_list: params[:tag_list]
      })
    end
  end
end
