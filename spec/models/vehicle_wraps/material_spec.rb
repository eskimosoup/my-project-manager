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
