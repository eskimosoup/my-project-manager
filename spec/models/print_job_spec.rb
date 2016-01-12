require 'rails_helper'

RSpec.describe PrintJob, type: :model do
  describe "validations", :validation do
    subject{ build(:print_job) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
    it { should validate_presence_of(:project) }
  end

  describe "associations", :association do
    it { should belong_to(:project) }
    it { should have_one(:brand).through(:project) }
    it { should have_many(:account_managements) }
    it { should have_many(:designs) }
    it { should have_many(:job_specifications) }
    it { should have_many(:labour_items) }
    it { should have_many(:mileages) }
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
    it { should delegate_method(:my_customer_price).to(:price_calculator) }
    it { should delegate_method(:my_customer_rush_job_price).to(:price_calculator) }
  end

  describe "#brand" do
    it { should delegate_method(:brand_type).to(:brand) }
  end

  describe "brand is envisage" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:price)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:rush_job_price).and_return(0.0)

      print_job.brand_rush_job_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:rush_job_price)
    end
  end
  
  describe "brand is envisage trade" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:trade_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:trade_price)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:trade_rush_job_price).and_return(0.0)

      print_job.brand_rush_job_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:trade_rush_job_price)
    end
  end

  describe "brand is my" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('my')
      allow(print_job).to receive(:my_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:my_price)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:brand_type).and_return('my')
      allow(print_job).to receive(:my_rush_job_price).and_return(0.0)

      print_job.brand_rush_job_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:my_rush_job_price)
    end
  end
end
