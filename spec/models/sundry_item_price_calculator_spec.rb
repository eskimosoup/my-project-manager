require "rails_helper"

describe SundryItemPriceCalculator, type: :model do
  describe "delegations", :delegation do
    subject { SundryItemPriceCalculator.new(sundry_item: nil) }
    it { should delegate_method(:cost).to(:sundry_item) }
  end

  it "should return the mark up" do
    calc = SundryItemPriceCalculator.new(sundry_item: nil) 
    expect(calc.decimal_mark_up).to eq(1.2)
  end

  describe "calculating the price" do
    it "with simple numbers" do
      si = double("sundry_item", cost: 15.0)
      calc = SundryItemPriceCalculator.new(sundry_item: si) 

      expect(calc.price).to eq(18.0)
    end

    it "when rounding is necessary" do
      si = double("sundry_item", cost: 3.53)
      calc = SundryItemPriceCalculator.new(sundry_item: si) 

      expect(calc.price).to eq(4.24)
    end
  end
end
