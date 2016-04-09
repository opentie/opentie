FactoryGirl.define do
  factory :delegate do
  end

  factory :delegate_observer, class: Delegate do
    permission "observer"
  end
end
