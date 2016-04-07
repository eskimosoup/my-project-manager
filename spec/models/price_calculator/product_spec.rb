require "rails_helper"

describe PriceCalculator::Product, type: :model do
  describe "delegations", :delegation do
    it do
      calc = PriceCalculator::Product.new(product: nil, area: nil) 

      expect(calc).to delegate_method(:substrate_cost).to(:product)
    end

    it do
      calc = PriceCalculator::Product.new(product: nil, area: nil) 

      expect(calc).to delegate_method(:hardware_cost).to(:product) 
    end

    it do
      calc = PriceCalculator::Product.new(product: nil, area: nil) 

      expect(calc).to delegate_method(:ink_cost).to(:product) 
    end

    it do
      calc = PriceCalculator::Product.new(product: nil, area: nil) 

      expect(calc).to delegate_method(:printer_cost).to(:product)
    end

    it do
      calc = PriceCalculator::Product.new(product: nil, area: nil) 

      expect(calc).to delegate_method(:mark_up).to(:product)
    end
  end

  describe "#variable_cost" do
    it "has no substrate_cost" do
      product = build(:product, substrate_cost: nil, hardware_cost: 100, ink_cost: 100)

      calc = PriceCalculator::Product.new(product: product, area: 5)

      expect(calc.variable_cost).to eq(1000)
    end

    it "has no hardware_cost" do
      product = build(:product, substrate_cost: 100, hardware_cost: nil, ink_cost: 100)

      calc = PriceCalculator::Product.new(product: product, area: 5)

      expect(calc.variable_cost).to eq(1000)
    end

    it "has no ink_cost" do
      product = build(:product, substrate_cost: 100, hardware_cost: 100, ink_cost: nil)

      calc = PriceCalculator::Product.new(product: product, area: 5)

      expect(calc.variable_cost).to eq(1000)
    end
  end

  describe "#fixed_cost" do
    it "has a printer cost" do
      product = build(:product, printer_cost: 100)

      calc = PriceCalculator::Product.new(product: product, area: 5)

      expect(calc.fixed_cost).to eq(500)
    end

    it "has no printer cost" do
      product = build(:product, printer_cost: nil)

      calc = PriceCalculator::Product.new(product: product, area: 5)

      expect(calc.fixed_cost).to eq(0)
    end
  end

  it "#cost" do
    calc = PriceCalculator::Product.new(product: nil, area: nil)
    allow(calc).to receive(:variable_cost).and_return(5)
    allow(calc).to receive(:fixed_cost).and_return(5)

    expect(calc.cost).to eq(10)
  end

  context "normal job" do
    it "#envisage_price" do
      product = build(:product, mark_up: 200)
      calc = PriceCalculator::Product.new(product: product, area: nil)
      allow(calc).to receive(:cost).and_return(100)

      expect(calc.envisage_price).to eq(200)
    end

    it "#envisage_trade_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_trade_price).to eq(90)
    end

    it "#envisage_to_my_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_to_my_price).to eq(80)
    end

    it "#my_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.my_price).to eq(120)
    end
  end

  context "rush job" do
    it "#envisage_rush_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_rush_price).to eq(150)
    end

    it "#envisage_trade_rush_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_trade_price).and_return(100)

      expect(calc.envisage_trade_rush_price).to eq(150)
    end

    it "#envisage_to_my_rush_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.envisage_to_my_rush_price).to eq(150)
    end

    it "#my_rush_price" do
      calc = PriceCalculator::Product.new(product: nil, area: nil)
      allow(calc).to receive(:my_price).and_return(100)

      expect(calc.my_rush_price).to eq(150)
    end
  end
end
