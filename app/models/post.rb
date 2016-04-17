class Post < ActiveRecord::Base

  belongs_to :division

  belongs_to :author, class_name: 'Account'
  belongs_to :topic_group
end
