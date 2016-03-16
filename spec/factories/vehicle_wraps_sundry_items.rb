FactoryGirl.define do
  factory :vehicle_wraps_sundry_item, class: 'VehicleWraps::SundryItem' do
    cost "9.99"
    vehicle_wrap nil
    name "MyString"
  end
end
