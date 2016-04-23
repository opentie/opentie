module Api::V1::Divisions
  class TopicsController < Api::V1::Divisions::BaseController

    before_action :division
    before_action :topic, except: [:new, :create, :index]

    def index
      topics = Topic.published.all
      render_paginate(topics)
    end

    def new
      render_ok
    end

    def show
      groups = @topic.group_topics.map do |gt|
        gt.group.attributes.merge({ group_topic_id: gt.id})
      end

      render_ok ({
        topic: @topic.attributes.merge({ groups: groups })
      })
    end

    def create
      CreateTopicService.
        new(@division, current_account).
        execute(project_params)

      render_ok
    end

    def edit
      group_ids = @topic.groups.pluck(:kibokan_id)

      render_ok({
        topic: @topic.attributes.merge({
          group_ids: group_ids
        })
      })
    end

    def update
      UpdateTopicService.
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
        @topic =Topic.includes(
          :groups,
          :group_topics,
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
