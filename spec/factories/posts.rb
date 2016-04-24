FactoryGirl.define do
  factory :post do
    body "post-body"
    is_draft false
  end

  factory :draft_post, class: Post do
    body "post-body"
    is_draft true
  end
end
