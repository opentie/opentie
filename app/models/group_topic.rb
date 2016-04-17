class GroupTopic < ActiveRecord::Base

  validates :topic_id, uniqueness: { scope: :group_id }

  belongs_to :group
  belongs_to :topic
end
