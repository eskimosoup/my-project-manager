FactoryGirl.define do
  factory :project do
    customer
    brand
    name "MyString"
    description "MyText"
    
    trait :quoted do
      status 0
    end

    trait :sold do
      status 1
    end

    trait :invoiced do
      status 2
    end

    trait :completed do
      status 3
    end

    factory :quoted_project, traits: [:quoted]
    factory :sold_project, traits: [:sold]
    factory :invoiced_project, traits: [:invoiced]
    factory :completed_project, traits: [:completed]
  end

end
