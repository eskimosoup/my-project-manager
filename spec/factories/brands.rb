FactoryGirl.define do
  factory :brand do
    sequence(:name){ |n| "My Brand #{ n }" }
    sequence(:email){ |n| "email#{ n }@example.com" }
    display false

    trait :my_office_branding do
      brand_type 0
    end

    trait :envisage do
      brand_type 1
    end

    trait :envisage_trade do
      brand_type 2
    end

    trait :my_vehicle_wrap do
      brand_type 3
    end

    factory :my_office_branding_brand, traits: [:my_office_branding]
    factory :envisage_brand, traits: [:envisage]
    factory :envisage_trade_brand, traits: [:envisage_trade]
    factory :my_vehicle_wrap_brand, traits: [:my_vehicle_wrap]
  end

end
