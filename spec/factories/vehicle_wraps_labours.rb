FactoryGirl.define do
  factory :vehicle_wraps_labour, class: 'VehicleWraps::Labour' do
    hours "9.99"
    vehicle_wrap nil
    labour nil
  end
end
