class Topic < ActiveRecord::Base

  acts_as_taggable

  has_many :group_topics, dependent: :destroy
  has_many :groups, -> { uniq }, through: :group_topics

  has_many :posts

  belongs_to :account
  belongs_to :proposer, polymorphic: true

  def add_groups(target_groups)
    ActiveRecord::Base.transaction do
      target_groups.each do |group|
        self.groups << group
      end
    end
  end

  def add_group(group)
    add_groups([group])
  end
end
