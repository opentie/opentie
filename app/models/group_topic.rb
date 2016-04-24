class GroupTopic < ActiveRecord::Base

  acts_as_taggable
  acts_as_taggable_on :labels, :tags

  validates :topic_id, uniqueness: { scope: :group_id }

  has_many :posts

  belongs_to :group
  belongs_to :topic
end
