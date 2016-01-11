require "rails_helper"

describe DesignPriceCalculator, type: :model do

  describe "#price" do
    it "calculates correctly" do
      calc = DesignPriceCalculator.new(hours: 1.to_d)

      expect(calc.price).to eq(65)
    end
    
    it "calculates correctly with decimal hours" do
      calc = DesignPriceCalculator.new(hours: 5.58.to_d)

      expect(calc.price).to eq(362.70)
    end
  end
end
