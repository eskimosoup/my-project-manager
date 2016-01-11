require "rails_helper"

describe JobSpecificationPriceCalculator, type: :model do
  it "#cost_per_hour" do
    calc = JobSpecificationPriceCalculator.new(hours: nil)

    expect(calc.cost_per_hour).to eq(15.00)
  end

  it "#decimal_mark_up" do
    calc = JobSpecificationPriceCalculator.new(hours: nil)

    expect(calc.decimal_mark_up).to eq(2.0)
  end
  
  describe "#cost" do
    it "correctly with simple values" do
      calc = JobSpecificationPriceCalculator.new(hours: 2)

      expect(calc.cost).to eq(30.00)
    end

    it "correctly when decimals need rounding" do
      calc = JobSpecificationPriceCalculator.new(hours: 0.355)

      expect(calc.cost).to eq(5.33)
    end
  end

  describe "#price the cost" do
    it "correctly with simple values" do
      calc = JobSpecificationPriceCalculator.new(hours: 2)
      allow(calc).to receive(:decimal_mark_up).and_return(2.0)
      allow(calc).to receive(:cost).and_return(3.0)

      expect(calc.price).to eq(6.0)
    end

    it "correctly when rounding is necessary" do
      calc = JobSpecificationPriceCalculator.new(hours: 2)
      allow(calc).to receive(:decimal_mark_up).and_return(2.25)
      allow(calc).to receive(:cost).and_return(3.25)

      expect(calc.price).to eq(7.31)
    end
  end
end
