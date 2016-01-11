require 'rails_helper'

RSpec.describe JobSpecification, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      job_spec = build_stubbed(:job_specification)
      expect(job_spec.price_calculator).to be_an_instance_of(JobSpecificationPriceCalculator)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
  end
end
