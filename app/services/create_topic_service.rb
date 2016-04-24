class CreateTopicService

  attr_accessor :proposer

  def initialize(proposer, account)
    @proposer, @account = proposer, account
  end

  def execute(params)
    is_draft = params.delete(:is_draft)
    group_ids = params.delete(:group_ids)
    tag_list = params.delete(:tag_list)

    groups = Group.where(kibokan_id: group_ids).to_a
    groups << @proposer if @proposer.class == Group

    topic = @proposer.proposal_topics.
      new(params.merge({ groups: groups.uniq, author: @account }))

    topic.group_topics.each do |gt|
      gt.tag_list = tag_list
      gt.save
    end

    topic.publish! unless is_draft
    topic.save!
    topic
  end
end
