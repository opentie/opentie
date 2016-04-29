module Api::V1::Divisions::Categories
  class TopicsController < Api::V1::Divisions::Categories::BaseController

    before_action :topic, except: [:new, :create, :index]

    def index
      topics = Topic.published.all
      render_paginate(topics)
    end

    def new
      render_ok
    end

    def show
      kibokan_ids = @topic.groups.pluck(:kibokan_id)
      entities = Group.get_entities(@category, kibokan_ids).group_by {|e| e.id }

      groups = @topic.group_topics.map do |gt|
        gt.group.attributes.merge({
          entity: entities[gt.group.kibokan_id].first,
          group_topic_id: gt.id,
          tags: gt.tag_list
        })
      end

      render_ok ({
        topic: @topic.attributes.merge({ groups: groups })
      })
    end

    def create
      CreateTopicService.
        new(@division, current_account).
        execute(topic_params)

      render_created
    end

    def edit
      group_ids = @topic.groups.pluck(:kibokan_id)
      tags = @topic.group_topics.first.tag_list

      render_ok({
        topic: @topic.attributes.merge({
          group_ids: group_ids,
          tags: tags
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

    def topic
      id = params[:topic_id] || params[:id]

      @topic =Topic.includes(
        :groups,
        :group_topics,
        group_topics: [:tags]
      ).find(id)

      ActiveRecord::RecordNotFound unless @topic
      @topic
    end

    def topic_params
      params.require(:topic).permit(
        :title, :description, :is_draft
      ).merge({
        group_ids: params[:group_ids],
        tag_list: params[:tag_list]
      })
    end
  end
end
