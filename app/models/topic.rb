class Topic < ActiveRecord::Base

  has_many :group_topics, dependent: :destroy
  has_many :groups, through: :group_topics

  belongs_to :account
  belongs_to :proposer, polymorphic: true

end
