FactoryGirl.define do
  factory :topic do
    title 'topic_name'
    description 'descriptions'
    is_draft false
  end

  factory :draft_topic, class: Topic do
    title 'topic_name'
    description 'descriptions'
    is_draft true
  end
end
