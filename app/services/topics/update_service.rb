module Topics
  class UpdateService

    attr_accessor :topic

    def initialize(topic)
      @topic = topic
    end

    def execute(params)
      is_draft = params.delete(:is_draft)
      group_ids = params.delete(:group_ids)
      tag_list = params.delete(:tag_list)

      @topic.publish! if !is_draft && topic.draft?
      @topic.update!(params)

      new_groups = Group.where(kibokan_id: group_ids).to_a
      new_groups << @topic.proposer if @topic.proposer.class == Group

      common_groups = new_groups & @topic.groups
      @topic.group_topics.where.not(group: common_groups).destroy_all
      @topic.add_groups(new_groups - common_groups)

      @topic.group_topics.each do |gt|
        gt.tag_list = tag_list
        gt.save
      end

      @topic.save!
      @topic
    end
  end
end
