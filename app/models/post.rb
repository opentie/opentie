class Post < ActiveRecord::Base

  belongs_to :topic
  belongs_to :group

  belongs_to :author, class_name: 'Account'
  belongs_to :topic_group
end
