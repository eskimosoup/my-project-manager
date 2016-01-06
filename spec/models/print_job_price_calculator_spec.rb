require "rails_helper"

describe PrintJobPriceCalculator, type: :model do
  describe "delegations", :delegation do
    subject { PrintJobPriceCalculator.new(print_job: instance_double("print_job")) }
    it { should delegate_method(:job_specifications).to(:print_job) }
    it { should delegate_method(:labour_items).to(:print_job) }
    it { should delegate_method(:product_items).to(:print_job) }
    it { should delegate_method(:sundry_items).to(:print_job) }
    it { should delegate_method(:supporting_product_items).to(:print_job) }
  end
end
