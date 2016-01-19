FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
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
