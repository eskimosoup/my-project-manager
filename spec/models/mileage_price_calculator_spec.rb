require "rails_helper"

describe MileagePriceCalculator, type: :model do
  it "returns the cost per mile" do
    calc = MileagePriceCalculator.new(miles: nil)

    expect(calc.cost_per_mile).to eq(0.40)
  end

  describe "calculating the mileage price" do
    it "correctly with simple values" do
      calc = MileagePriceCalculator.new(miles: 2)

      expect(calc.price).to eq(0.80)
    end

    it "correctly when decimals need rounding" do
      calc = MileagePriceCalculator.new(miles: 40.53)

      expect(calc.price).to eq(16.21)
    end
  end

  describe "calculating the cost" do
    it "is aliased to price" do
      calc = MileagePriceCalculator.new(miles: 2)

      expect(calc.price).to eq(calc.cost)
    end
  end

end
