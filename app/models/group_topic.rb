class GroupTopic < ActiveRecord::Base

  acts_as_taggable

  validates :topic_id, uniqueness: { scope: :group_id }

  has_many :posts

  belongs_to :group
  belongs_to :topic
end
