require "rails_helper"

describe LabourPriceCalculator, type: :model do
  describe "delegations", :delegation do
    subject { LabourPriceCalculator.new(labour: nil, hours: nil) }
    it { should delegate_method(:per_hour).to(:labour) }
    it { should delegate_method(:mark_up).to(:labour) }
  end

  it "calculating mark up as a decimal" do
    labour = instance_double("labour", mark_up: 240)
    calc = LabourPriceCalculator.new(labour: labour, hours: nil)

    expect(calc.decimal_mark_up).to eq(2.40)
  end

  describe "calculating cost" do
    it "correctly" do
      labour = instance_double("labour", per_hour: 15.00)
      calc = LabourPriceCalculator.new(labour: labour, hours: 3)

      expect(calc.cost).to eq(45.00)
    end

    it "correctly when using decimal hour numbers" do
      labour = instance_double("labour", per_hour: 15.00)
      calc = LabourPriceCalculator.new(labour: labour, hours: 2.5)

      expect(calc.cost).to eq(37.50)
    end

    it "correctly when rounding" do
      labour = instance_double("labour", per_hour: 15.45)
      calc = LabourPriceCalculator.new(labour: labour, hours: 2.5)

      expect(calc.cost).to eq(38.63)
    end
  end

  describe "calculating the price" do
    it "correctly" do
      labour = instance_double("labour", mark_up: 240)
      calc = LabourPriceCalculator.new(labour: labour, hours: nil)
      allow(calc).to receive(:cost).and_return(35.50)

      expect(calc.price).to eq(85.20)
      expect(calc).to have_received(:cost)
    end

    it "correctly when rounding necessary" do
      labour = instance_double("labour", mark_up: 240)
      calc = LabourPriceCalculator.new(labour: labour, hours: nil)
      allow(calc).to receive(:cost).and_return(30.53)

      expect(calc.price).to eq(73.27)
      expect(calc).to have_received(:cost)
    end
  end
end
