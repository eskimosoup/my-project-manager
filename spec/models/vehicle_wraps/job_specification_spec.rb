require 'rails_helper'

RSpec.describe VehicleWraps::JobSpecification, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_wrap) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      job_spec = build_stubbed(:vehicle_wraps_job_specification)
      expect(job_spec.price_calculator).to be_an_instance_of(JobSpecificationPriceCalculator)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
  end
end
