# == Schema Information
#
# Table name: product_items
#
#  id           :integer          not null, primary key
#  actual_area  :decimal(15, 3)
#  actual_cost  :decimal(10, 2)
#  area         :decimal(15, 3)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer          not null
#  product_id   :integer          not null
#
# Indexes
#
#  index_product_items_on_print_job_id  (print_job_id)
#  index_product_items_on_product_id    (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#  fk_rails_...  (product_id => products.id) ON DELETE => cascade
#
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
      expect(product_item.price_calculator).to be_an_instance_of(PriceCalculator::Product)
    end
    
    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:fixed_cost).to(:price_calculator) }
    it { should delegate_method(:variable_cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:envisage_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_rush_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_price).to(:price_calculator) }
  end
end
