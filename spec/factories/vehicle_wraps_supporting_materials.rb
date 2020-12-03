# == Schema Information
#
# Table name: vehicle_wraps_supporting_materials
#
#  id                    :integer          not null, primary key
#  area                  :decimal(15, 3)   not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  supporting_product_id :integer
#  vehicle_wrap_id       :integer
#
# Indexes
#
#  supporting_product_supporting_materials  (supporting_product_id)
#  vehicle_wrap_supporting materials        (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (supporting_product_id => supporting_products.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :vehicle_wraps_supporting_material, class: 'VehicleWraps::SupportingMaterial' do
    area "9.99"
    vehicle_wrap nil
    supporting_product nil
  end
end
