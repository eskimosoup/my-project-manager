require "rails_helper"

describe JobSpecificationPriceCalculator, type: :model do
  it "returns the cost per hour" do
    calc = JobSpecificationPriceCalculator.new(hours: nil)

    expect(calc.cost_per_hour).to eq(15.00)
  end
  
  describe "calculating the specification price" do
    it "correctly with simple values" do
      calc = JobSpecificationPriceCalculator.new(hours: 2)

      expect(calc.price).to eq(30.00)
    end

    it "correctly when decimals need rounding" do
      calc = JobSpecificationPriceCalculator.new(hours: 0.355)

      expect(calc.price).to eq(5.33)
    end
  end

  describe "calculating the cost" do
    it "is aliased to price" do
      calc = JobSpecificationPriceCalculator.new(hours: 2)

      expect(calc.price).to eq(calc.cost)
    end
  end
end
