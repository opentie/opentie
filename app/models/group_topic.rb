class GroupTopic < ActiveRecord::Base
  belongs_to :group
  belongs_to :topic
end
