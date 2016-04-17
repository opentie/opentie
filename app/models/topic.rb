class Topic < ActiveRecord::Base

  has_many :group_topics, dependent: :delete_all
  has_many :groups, through: :group_topics

  belongs_to :account
  belongs_to :proposer, polymorphic: true

  scope :draft, -> { where(is_draft: true) }
  scope :published, -> { where(is_draft: false) }

end
