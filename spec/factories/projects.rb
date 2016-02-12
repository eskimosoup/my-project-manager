FactoryGirl.define do
  factory :project do
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

    trait :finalised do
      status 2
    end

    trait :completed do
      status 3
    end

    factory :quoted_project, traits: [:quoted]
    factory :sold_project, traits: [:sold]
    factory :finalised_project, traits: [:finalised]
    factory :completed_project, traits: [:completed]
  end

end
