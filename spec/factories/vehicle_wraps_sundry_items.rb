# == Schema Information
#
# Table name: vehicle_wraps_sundry_items
#
#  id              :integer          not null, primary key
#  cost            :decimal(15, 2)   not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_sundry_items_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :vehicle_wraps_sundry_item, class: 'VehicleWraps::SundryItem' do
    cost "9.99"
    vehicle_wrap nil
    name "MyString"
  end
end
