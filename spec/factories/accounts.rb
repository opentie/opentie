FactoryGirl.define do
  factory :account do
    password "passward"
    password_confirmation "passward"
    email "opentie@example.com"
    kibokan_id 0
    is_admin false
  end

  factory :admin, class: Account do
    password "passward"
    password_confirmation "passward"
    email "admin.opentie@example.com"
    kibokan_id 0
    is_admin true
  end
end
