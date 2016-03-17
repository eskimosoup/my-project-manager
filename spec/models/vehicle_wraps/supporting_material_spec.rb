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
      expect(subject.price_calculator).to be_an_instance_of(SupportingProductPriceCalculator)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
  end
end
