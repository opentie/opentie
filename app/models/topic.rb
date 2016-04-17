class Topic < ActiveRecord::Base

  has_many :group_topics, dependent: :delete_all
  has_many :groups, through: :group_topics

  belongs_to :author, class_name: 'Account'
  belongs_to :proposer, polymorphic: true

  scope :draft, -> { where(is_draft: true) }
  scope :published, -> { where(is_draft: false) }

  def add_groups(groups)
    groups.each do |g|
      self.groups << g
    end
  end

  def publish
    raise ActiveRecord::RecordInvalid unless self.is_draft
    self.update(is_draft: false, sended_at: Time.now)
  end

  def publish?
    !is_draft
  end

  def draft?
    is_draft
  end
end
