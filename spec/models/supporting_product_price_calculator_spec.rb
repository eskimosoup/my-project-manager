require "rails_helper"

describe SupportingProductPriceCalculator, type: :model do
  describe "delegations", :delegation do
    subject { SupportingProductPriceCalculator.new(supporting_product: nil, area: nil) }
    it { should delegate_method(:mark_up).to(:supporting_product) }
    it { should delegate_method(:substrate_cost).to(:supporting_product) }
  end

  describe "calculating cost" do
    it "correctly" do
      supporting_product = instance_double("supporting_product", substrate_cost: 2.40)
      calc = SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: 1)

      expect(calc.cost).to eq(2.40)
    end

    it "correctly when rounding decimals where necessary" do
      supporting_product = instance_double("supporting_product", substrate_cost: 2.40)
      calc = SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: 2.53)

      expect(calc.cost).to eq(6.07)
    end
  end

  describe "calculating the price" do
    it "correctly" do
      supporting_product = instance_double("supporting_product", mark_up: 240)
      calc = SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: nil)
      allow(calc).to receive(:cost).and_return(2.53)

      expect(calc.price).to eq(6.07)
      expect(calc).to have_received(:cost)
    end
  end

  it "working out mark up as a decimal" do
    supporting_product = instance_double("supporting_product", mark_up: 240)
    calc = SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: nil)

    expect(calc.decimal_mark_up).to eq(2.40)
  end
end
