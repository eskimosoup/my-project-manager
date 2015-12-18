require "rails_helper"

describe ProductPricingCalculator, type: :model do
  
  describe "calculating variable costs" do
    it "correctly" do
      product = instance_double("product", substrate_cost: 5.50, hardware_cost: 1.50, ink_cost: 2.50)
      calc = ProductPricingCalculator.new(product: product, area: 1)

      expect(calc.variable_cost).to eq(9.50)
    end

    it "even when one of the costs is nil" do
      product = instance_double("product", substrate_cost: nil, hardware_cost: 1.50, ink_cost: 2.50)
      calc = ProductPricingCalculator.new(product: product, area: 1)

      expect(calc.variable_cost).to eq(4.00)
    end
  end

  describe "calculating fixed costs" do
    it "correctly" do
      product = instance_double("product", printer_cost: nil)
      calc = ProductPricingCalculator.new(product: product, area: 1)

      expect(calc.fixed_cost).to eq(0.00)
    end
  end
end

