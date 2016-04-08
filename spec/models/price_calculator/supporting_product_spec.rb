require "rails_helper"

describe PriceCalculator::SupportingProduct, type: :model do
  describe "delegations", :delegation do
    it do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      expect(calc).to delegate_method(:mark_up).to(:supporting_product)
    end

    it do 
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil) 
      expect(calc).to delegate_method(:substrate_cost).to(:supporting_product)
    end
  end

  it "#cost" do
    supporting_product = build(:supporting_product, substrate_cost: 5)
    calc = PriceCalculator::SupportingProduct.new(supporting_product: supporting_product, area: 5)

    expect(calc.cost).to eq(25)
  end

  context "normal job" do
    it "#envisage_price" do
      supporting_product = build(:supporting_product, mark_up: 200)
      calc = PriceCalculator::SupportingProduct.new(supporting_product: supporting_product, area: 5)
      allow(calc).to receive(:cost).and_return(200)

      expect(calc.envisage_price).to eq(400)
    end

    it "#envisage_trade_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_trade_price).to eq(90)
    end

    it "#envisage_to_my_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_to_my_price).to eq(80)
    end

    it "#my_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.my_price).to eq(135)
    end
  end

  context "rush job" do
    it "#envisage_rush_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_price).and_return(100)

      expect(calc.envisage_rush_price).to eq(150)
    end

    it "#envisage_trade_rush_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_trade_price).and_return(100)

      expect(calc.envisage_trade_rush_price).to eq(150)
    end

    it "#envisage_to_my_rush_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:envisage_to_my_price).and_return(100)

      expect(calc.envisage_to_my_rush_price).to eq(150)
    end

    it "#my_rush_price" do
      calc = PriceCalculator::SupportingProduct.new(supporting_product: nil, area: nil)
      allow(calc).to receive(:my_price).and_return(100)

      expect(calc.my_rush_price).to eq(150)
    end
  end
end
