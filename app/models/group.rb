class Group < ActiveRecord::Base

  include Kibokan::RequestQuery

  has_many :delegates, dependent: :delete_all
  has_many :accounts, through: :delegates

  has_many :group_topics, dependent: :delete_all
  has_many :topics, through: :group_topics

  has_many :invitation_tokens, as: :organization
  has_many :proposal_topics, class_name: "Topic", as: :proposer

  scope :active, -> { where(frozen_at: nil) }

  def self.create_with_kibokan(account, params)
    kibokan_params = params.delete(:kibokan)
    category_name = params[:category_name]

    group = new(params)
    entity = insert_entity(category_name, kibokan_params)

    group.kibokan_id = entity.id
    group.save

    group.delegates.create(account: account, permission: 'super')
    group
  end

  def update_with_kibokan(params)
    kibokan_params = params.delete(:kibokan)
    entity = update_entity(kibokan_params)

    is_froze = params.delete(:is_froze)
    froze if is_froze

    update(params)
    self.kibokan_id = entity.id
    save
    self
  end

  def name
    entity = self.get_entity
    entity.name
  end

  def active?
    self.frozen_at.nil?
  end

  def froze
    update(frozen_at: Time.zone.now)
  end

  # override on Kibokan::RequestQuery
  def current_category
    self.category_name
  end
end
