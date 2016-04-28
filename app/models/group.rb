class Group < ActiveRecord::Base

  include Kibokan::RequestQuery

  has_many :delegates, dependent: :delete_all
  has_many :accounts, through: :delegates

  has_many :group_topics, dependent: :delete_all
  has_many :topics, through: :group_topics

  has_many :proposal_topics, class_name: "Topic", as: :proposer

  def self.create_with_kibokan(params)
    kibokan_params = params.delete(:kibokan)
    category_name = params[:category_name]

    group = new(category_name: category_name)
    entity = insert_entity(category_name, kibokan_params)

    group.kibokan_id = entity.id
    group.save
    group
  end

  def update_with_kibokan(params)
    kibokan_params = params.delete(:kibokan)
    entity = update_entity(kibokan_params)

    update(params)
    self.kibokan_id = entity.id
    save
    self
  end

  # override on Kibokan::RequestQuery
  def current_category
    self.category_name
  end
end
