# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  description    :text
#  hardware_cost  :decimal(5, 2)
#  ink_cost       :decimal(5, 2)
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  printer_cost   :decimal(5, 2)
#  substrate_cost :decimal(5, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:substrate_cost) }
    it { should validate_numericality_of(:substrate_cost).is_greater_than(0) }
    it { should validate_numericality_of(:hardware_cost).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:ink_cost).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:printer_cost).is_greater_than(0).allow_nil }
    it { should validate_presence_of(:mark_up) }
    it { should validate_numericality_of(:mark_up).only_integer.is_greater_than(100) }
    
    describe "uniqueness" do
      subject { build(:product) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  describe "associations", :association do
    it { should have_many(:product_costs) }
  end

end
