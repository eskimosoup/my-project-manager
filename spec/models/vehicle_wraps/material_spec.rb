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
require 'rails_helper'

RSpec.describe VehicleWraps::Material, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:product) }
    it { should belong_to(:vehicle_wrap) }
  end

  it { should delegate_method(:name).to(:product) }

  describe "product price calculator" do
    it "#product_price_calculator" do
      material = build_stubbed(:vehicle_wraps_material)
      expect(material.price_calculator).to be_an_instance_of(PriceCalculator::Product)
    end
    
    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
