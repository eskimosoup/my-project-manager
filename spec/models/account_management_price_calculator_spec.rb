require "rails_helper"

describe AccountManagementPriceCalculator, type: :model do

  describe "#price" do
    it "calculates correctly" do
      calc = AccountManagementPriceCalculator.new(hours: 1.to_d, rate: 30)

      expect(calc.price).to eq(30)
    end
    
    it "calculates correctly with decimal hours" do
      calc = AccountManagementPriceCalculator.new(hours: 5.58.to_d, rate: 30)

      expect(calc.price).to eq(167.40)
    end
  end

  it "calculates correctly" do
    calc = AccountManagementPriceCalculator.new(hours: 1.to_d, rate: 30)

    expect(calc.cost).to eq(0)
  end
end
