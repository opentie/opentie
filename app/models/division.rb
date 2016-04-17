class Division < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :accounts, through: :roles

  has_many :invitation_tokens

  has_many :proposal_topics, class_name: "Topic", as: :proposer
end
