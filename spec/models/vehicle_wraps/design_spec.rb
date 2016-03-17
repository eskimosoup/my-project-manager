require 'rails_helper'

RSpec.describe VehicleWraps::Design, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than(0.0) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_wrap) }
  end

  describe "price_calculator" do
    it "#price_calculator" do
      design = build_stubbed(:vehicle_wraps_design)

      expect(design.price_calculator).to be_an_instance_of(DesignPriceCalculator)
    end

    it { should delegate_method(:price).to(:price_calculator) }
    it { should delegate_method(:cost).to(:price_calculator) }
  end
end
