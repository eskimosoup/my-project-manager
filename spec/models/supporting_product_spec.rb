# == Schema Information
#
# Table name: supporting_products
#
#  id             :integer          not null, primary key
#  description    :text
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  substrate_cost :decimal(7, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_supporting_products_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe SupportingProduct, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:substrate_cost) }
    it { should validate_numericality_of(:substrate_cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:mark_up) }
    it { should validate_numericality_of(:mark_up).only_integer.is_greater_than_or_equal_to(100) }

    describe "uniqueness" do
      subject { build(:supporting_product) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
