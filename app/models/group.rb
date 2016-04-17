class Group < ActiveRecord::Base

  has_many :delegates, dependent: :destroy
  has_many :accounts, through: :delegates

  has_many :group_topics, dependent: :destroy
  has_many :topics, through: :group_topics

  has_many :proposal_topics, class_name: "Topic", as: :proposer
end
