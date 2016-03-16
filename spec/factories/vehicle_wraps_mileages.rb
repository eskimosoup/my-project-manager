FactoryGirl.define do
  factory :vehicle_wraps_mileage, class: 'VehicleWraps::Mileage' do
    miles "9.99"
    vehicle_wrap nil
  end
end
