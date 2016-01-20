FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    first_name "First"
    last_name "Last"
    username "MyString"
    email
    password "password"
    admin false
    trait :admin do
      admin true
    end

    factory :admin_user, traits: [:admin]
  end
end
