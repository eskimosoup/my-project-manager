require "rails_helper"

describe PriceCalculator::AccountManagement, type: :model do
  it "#cost" do
    calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

    expect(calc.cost).to eq(0)
  end

  context "normal job" do
    it "#envisage_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_price).to eq(0)
    end

    it "#envisage_trade_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_trade_price).to eq(0)
    end

    it "#envisage_to_my_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_to_my_price).to eq(0)
    end

    it "#my_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 2, rate: 30)

      expect(calc.my_price).to eq(60)
    end

  end

  context "rush job" do
    it "#envisage_rush_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_rush_price).to eq(0)
    end

    it "#envisage_trade_rush_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_trade_rush_price).to eq(0)
    end

    it "#envisage_to_my_rush_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 1, rate: 30)

      expect(calc.envisage_to_my_rush_price).to eq(0)
    end

    it "#my_rush_price" do
      calc = PriceCalculator::AccountManagement.new(hours: 2, rate: 30)
      allow(calc).to receive(:my_price).and_return(60)

      expect(calc.my_rush_price).to eq(90)
    end
  end
end
