require 'rails_helper'

RSpec.describe Mileage, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:miles) }
    it { should validate_numericality_of(:miles).is_greater_than(0.0) }
    it { should validate_presence_of(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end

  describe "#price_calculator" do
    it "returns an instance of the price calculator" do
      expect(subject.price_calculator).to be_an_instance_of(PriceCalculator::Mileage)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
