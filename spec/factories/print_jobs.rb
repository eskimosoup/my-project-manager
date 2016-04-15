FactoryGirl.define do
  factory :print_job do
    project
    sequence(:name) {|x| "Print Job #{ x }" }
    description "My description"
    trait :with_prices do
      envisage_sale_price 5.00
      envisage_trade_sale_price 10.00
      envisage_to_my_sale_price 15.00
      my_sale_price 20.00
    end

    factory :sold_print_job, traits: [:with_prices]
    factory :finalised_print_job, traits: [:with_prices]
  end

end
