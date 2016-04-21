FactoryGirl.define do
  factory :role do
  end

  factory :role_observer, class: Role do
    permission "observer"
  end
end
