class Division < ActiveRecord::Base

  has_many :roles, dependent: :delete_all
  has_many :accounts, through: :roles

  has_many :invitation_tokens, as: :organization

  has_many :proposal_topics, class_name: "Topic", as: :proposer
  has_many :posts
end
