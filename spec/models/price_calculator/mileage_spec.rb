require "rails_helper"

describe PriceCalculator::Mileage, type: :model do
  it "#cost" do
    calc = PriceCalculator::Mileage.new(miles: 3)

    expect(calc.cost).to eq(1.20)
  end

  context "normal job" do
    it "#envisage_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_price).to eq(1.20)
    end

    it "#envisage_trade_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_trade_price).to eq(1.20)
    end

    it "#envisage_to_my_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_to_my_price).to eq(1.20)
    end

    it "#my_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.my_price).to eq(1.20)
    end
  end

  context "rush job" do
    it "#envisage_rush_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_rush_price).to eq(1.20)
    end

    it "#envisage_trade_rush_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_trade_rush_price).to eq(1.20)
    end

    it "#envisage_to_my_rush_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.envisage_to_my_rush_price).to eq(1.20)
    end

    it "#my_rush_price" do
      calc = PriceCalculator::Mileage.new(miles: 3)

      expect(calc.my_rush_price).to eq(1.20)
    end
  end
end
