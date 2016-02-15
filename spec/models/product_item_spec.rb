require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:product) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
    it { should belong_to(:product) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "product" do
    it { should delegate_method(:name).to(:product) }
  end

  describe "product price calculator" do
    it "#product_price_calculator" do
      product_item = build_stubbed(:product_item)
      expect(product_item.price_calculator).to be_an_instance_of(ProductPriceCalculator)
    end
    
    it { should delegate_method(:variable_cost).to(:price_calculator) }
    it { should delegate_method(:fixed_cost).to(:price_calculator) }
    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
  end
end
