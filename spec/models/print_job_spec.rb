require 'rails_helper'

RSpec.describe PrintJob, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
    it { should validate_presence_of(:project) }
  end

  describe "associations", :association do
    it { should have_many(:job_specifications) }
    it { should have_many(:labour_items) }
    it { should have_many(:mileages) }
    it { should belong_to(:project) }
    it { should have_many(:product_items) }
    it { should have_many(:sundry_items) }
    it { should have_many(:supporting_product_items) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      print_job = build_stubbed(:print_job)
      expect(print_job.price_calculator).to be_an_instance_of(PrintJobPriceCalculator)
    end

    it { should delegate_method(:cost_without_labour_or_printer).to(:price_calculator) }
    it { should delegate_method(:cost_without_mileage).to(:price_calculator) }
    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:price).to(:price_calculator) }
    it { should delegate_method(:rush_job_price).to(:price_calculator) }
    it { should delegate_method(:trade_price).to(:price_calculator) }
    it { should delegate_method(:trade_rush_job_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_job_price).to(:price_calculator) }
  end
end
