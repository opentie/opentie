class Post < ActiveRecord::Base

  acts_as_taggable

  belongs_to :topic
  belongs_to :group

  belongs_to :author, class_name: 'Account'
end
