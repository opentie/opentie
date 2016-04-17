module Topics
  class CreateService

    attr_accessor :proposer

    def initialize(proposer)
      @proposer = proposer
    end

    def execute(params, author, is_draft, group_ids)
      groups = Group.where(kibokan_id: group_ids).to_a

      groups << @proposer if @proposer.class == Group

      topic = @proposer.proposal_topics.
        new(params.merge({ groups: groups.uniq, author: author }))

      topic.publish unless is_draft
      topic.save!
      topic
    end
  end
end
