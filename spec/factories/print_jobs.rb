FactoryGirl.define do
  factory :print_job do
    project
    sequence(:name) {|x| "Print Job #{ x }" }
    trait :sold do
      envisage_sale_price 5.00
      envisage_trade_sale_price 10.00
      envisage_to_my_sale_price 15.00
      my_sale_price 20.00
    end

    factory :sold_print_job, traits: [:sold]
    factory :finalised_print_job, traits: [:sold]
  end

end
