# == Schema Information
#
# Table name: vehicle_wraps_materials
#
#  id              :integer          not null, primary key
#  area            :decimal(15, 3)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_materials_on_product_id       (product_id)
#  index_vehicle_wraps_materials_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :vehicle_wraps_material, class: 'VehicleWraps::Material' do
    area "9.99"
    vehicle_wrap nil
    product nil
  end
end
