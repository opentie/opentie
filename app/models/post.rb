class Post < ActiveRecord::Base

  belongs_to :division

  belongs_to :author, class_name: 'Account'
  belongs_to :group_topic

  scope :draft, -> { where(is_draft: true) }
  scope :published, -> { where(is_draft: false) }

  def publish!
    return if published?
    self.update(is_draft: false, sended_at: Time.now)
  end

  def published?
    !is_draft && !sended_at.nil?
  end

  def draft?
    is_draft
  end
end
