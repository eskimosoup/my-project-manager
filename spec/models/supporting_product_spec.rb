require 'rails_helper'

RSpec.describe SupportingProduct, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:substrate_cost) }
    it { should validate_numericality_of(:substrate_cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:mark_up) }
    skip { should validate_numericality_of(:mark_up).only_integer.is_greater_than_or_equal_to(100) }

    describe "uniqueness" do
      subject { build(:supporting_product) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
