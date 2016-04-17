module Topics
  class CreateService

    attr_accessor :proposer

    def initialize(proposer)
      @proposer = proposer
    end

    def execute(params, author, group_ids)
      groups = Group.where(kibokan_id: group_ids)

      groups << @proposer if @proposer.class == Group

      topic = @proposer.proposal_topics.
        new(params.merge({ groups: groups.uniq, author: author }))
      topic.sended_at = Time.now unless params[:is_draft]

      topic.save!
      topic
    end
  end
end
