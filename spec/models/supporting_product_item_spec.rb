require 'rails_helper'

RSpec.describe SupportingProductItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:supporting_product) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
    it { should belong_to(:supporting_product) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "supporting product" do
    it { should delegate_method(:name).to(:supporting_product) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      supporting_product_item = build_stubbed(:supporting_product_item)
      expect(supporting_product_item.price_calculator).to be_an_instance_of(PriceCalculator::SupportingProduct)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
