require "rails_helper"

describe PriceCalculator::SundryItem, type: :model do
  describe "delegations", :delegation do
    it do
      calc = PriceCalculator::SundryItem.new(sundry_item: nil)
      expect(calc).to delegate_method(:cost).to(:sundry_item)
    end
  end

  context "normal job" do
    it "#envisage_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_price).to eq(120)
    end

    it "#envisage_trade_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_trade_price).to eq(120)
    end

    it "#envisage_to_my_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_to_my_price).to eq(120)
    end

    it "#my_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.my_price).to eq(140)
    end
  end

  context "rush job" do
    it "#envisage_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_rush_price).to eq(180)
    end

    it "#envisage_trade_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_trade_rush_price).to eq(180)
    end

    it "#envisage_to_my_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.envisage_to_my_rush_price).to eq(180)
    end

    it "#my_price" do
      sundry_item = build(:sundry_item, cost: 100)

      calc = PriceCalculator::SundryItem.new(sundry_item: sundry_item)

      expect(calc.my_rush_price).to eq(210)
    end

  end

end
