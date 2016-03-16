FactoryGirl.define do
  factory :vehicle_wrap do
    vehicle_type nil
    name "MyString"
    description "MyText"
    envisage_override_price "9.99"
    envisage_trade_override_price "9.99"
    envisage_to_my_override_price "9.99"
    my_override_price "9.99"
  end
end
