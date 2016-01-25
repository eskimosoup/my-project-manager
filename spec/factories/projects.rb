FactoryGirl.define do
  factory :project do
    sequence(:id){ |n| n }
    customer
    brand
    name "MyString"
    description "MyText"
    rush_job false

    trait :quoted do
      status 0
    end

    trait :sold do
      status 1
    end

    trait :completed do
      status 2
    end

    factory :quoted_project, traits: [:quoted]
    factory :sold_project, traits: [:sold]
    factory :completed_project, traits: [:completed]
  end

end
