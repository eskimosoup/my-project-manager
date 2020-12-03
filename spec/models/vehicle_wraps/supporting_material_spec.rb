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
require 'rails_helper'

RSpec.describe VehicleWraps::SupportingMaterial, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:supporting_product) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:supporting_product) }
    it { should belong_to(:vehicle_wrap) }
  end

  it { should delegate_method(:name).to(:supporting_product) }

  describe "price calculator" do
    it "#price_calculator" do
      expect(subject.price_calculator).to be_an_instance_of(PriceCalculator::SupportingProduct)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
  end
end
