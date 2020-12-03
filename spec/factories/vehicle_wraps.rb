# == Schema Information
#
# Table name: vehicle_wraps
#
#  id                            :integer          not null, primary key
#  description                   :text             not null
#  envisage_override_price       :decimal(10, 2)
#  envisage_to_my_override_price :decimal(10, 2)
#  envisage_trade_override_price :decimal(10, 2)
#  my_override_price             :decimal(10, 2)
#  name                          :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  vehicle_type_id               :integer
#
# Indexes
#
#  index_vehicle_wraps_on_vehicle_type_id  (vehicle_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_type_id => vehicle_types.id) ON DELETE => cascade
#
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
