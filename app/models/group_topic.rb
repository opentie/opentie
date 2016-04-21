class GroupTopic < ActiveRecord::Base

  acts_as_taggable

  validates :topic_id, uniqueness: { scope: :group_id }

  belongs_to :group
  belongs_to :topic
end
