require 'rails_helper'

RSpec.describe LabourItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:labour) }
    it { should validate_presence_of(:print_job) }
  end

  describe "associations", :association do
    it { should belong_to(:labour) }
    it { should belong_to(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "labour" do
    it { should delegate_method(:name).to(:labour) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      labour_item = build_stubbed(:labour_item)
      expect(labour_item.price_calculator).to be_an_instance_of(LabourPriceCalculator)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
  end
end
