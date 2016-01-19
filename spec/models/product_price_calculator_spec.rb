require "rails_helper"

describe ProductPriceCalculator, type: :model do
  
  describe "delegations", :delegation do
    subject { ProductPriceCalculator.new(product: nil, area: nil) }
    it { should delegate_method(:substrate_cost).to(:product) }
    it { should delegate_method(:hardware_cost).to(:product) }
    it { should delegate_method(:ink_cost).to(:product) }
    it { should delegate_method(:printer_cost).to(:product) }
    it { should delegate_method(:mark_up).to(:product) }
  end

  describe "#variable_costs" do
    it "correctly" do
      product = instance_double("product", substrate_cost: 5.50, hardware_cost: 1.50, ink_cost: 2.50)
      calc = ProductPriceCalculator.new(product: product, area: 1)

      expect(calc.variable_cost).to eq(9.50)
    end

    it "correctly even when one of the costs is nil" do
      product = instance_double("product", substrate_cost: nil, hardware_cost: 1.50, ink_cost: 2.50)
      calc = ProductPriceCalculator.new(product: product, area: 1)

      expect(calc.variable_cost).to eq(4.00)
    end

    it "correctly with decimal areas and rounds" do
      product = instance_double("product", substrate_cost: 5.50, hardware_cost: 1.50, ink_cost: 2.50)
      calc = ProductPriceCalculator.new(product: product, area: 2.55)
      
      expect(calc.variable_cost).to eq(24.23)
    end
  end

  describe "#fixed_cost" do
    it "correctly when printer cost is nil" do
      product = instance_double("product", printer_cost: nil)
      calc = ProductPriceCalculator.new(product: product, area: 1)

      expect(calc.fixed_cost).to eq(0.00)
    end

    it "correctly" do
      product = instance_double("product", printer_cost: 2.50)
      calc = ProductPriceCalculator.new(product: product, area: 1)

      expect(calc.fixed_cost).to eq(2.50)
    end

    it "correctly with decimals" do
      product = instance_double("product", printer_cost: 2.50)
      calc = ProductPriceCalculator.new(product: product, area: 3.53)

      expect(calc.fixed_cost).to eq(8.83)
    end
  end

  describe "#cost" do
    it "correctly" do
      calc = ProductPriceCalculator.new(product: nil, area: nil)
      allow(calc).to receive(:variable_cost).and_return(5.50)
      allow(calc).to receive(:fixed_cost).and_return(2.50)

      expect(calc.cost).to eq(8.00)
      expect(calc).to have_received(:variable_cost)
      expect(calc).to have_received(:fixed_cost)
    end
  end
  
  describe "#price" do
    it "correctly" do
      product = instance_double("product", mark_up: 250)
      calc = ProductPriceCalculator.new(product: product, area: nil)
      allow(calc).to receive(:cost).and_return(2.50)

      expect(calc.price).to eq(6.25)
    end

    it "correctly and rounds decimals" do
      product = instance_double("product", mark_up: 250)
      calc = ProductPriceCalculator.new(product: product, area: nil)
      allow(calc).to receive(:cost).and_return(3.23)

      expect(calc.price).to eq(8.08)
    end
  end
 
  it "#decimal_mark_up" do
    product = instance_double("product", mark_up: 250)
    calc = ProductPriceCalculator.new(product: product, area: nil)

    expect(calc.decimal_mark_up).to eq(2.50)
  end
end

