# == Schema Information
#
# Table name: vehicle_wraps_mileages
#
#  id              :integer          not null, primary key
#  miles           :decimal(15, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_mileages_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :vehicle_wraps_mileage, class: 'VehicleWraps::Mileage' do
    miles "9.99"
    vehicle_wrap nil
  end
end
