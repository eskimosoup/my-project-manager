# == Schema Information
#
# Table name: print_jobs
#
#  id                        :integer          not null, primary key
#  cost                      :decimal(10, 2)
#  description               :text
#  envisage_sale_price       :decimal(10, 2)
#  envisage_to_my_sale_price :decimal(10, 2)
#  envisage_trade_sale_price :decimal(10, 2)
#  my_sale_price             :decimal(10, 2)
#  my_service_item_costs     :decimal(, )      default(0.0)
#  name                      :text             not null
#  position                  :integer
#  vat                       :boolean          default(TRUE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_id                :integer
#
# Indexes
#
#  index_print_jobs_on_project_id           (project_id)
#  index_print_jobs_on_project_id_and_name  (project_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
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
    it { should have_many(:discounts).through(:project) }
    it { should have_many(:job_specifications) }
    it { should have_many(:labour_items) }
    it { should have_many(:mileages) }
    it { should have_many(:my_service_items) }
    it { should have_many(:product_costs) }
    it { should have_many(:product_items) }
    it { should have_many(:sundry_costs) }
    it { should have_many(:sundry_items) }
    it { should have_many(:supporting_product_costs) }
    it { should have_many(:supporting_product_items) }
  end

  it { should delegate_method(:rush_job?).to(:project) }
  it { should delegate_method(:quoted?).to(:project) }
  it { should delegate_method(:sold?).to(:project) }
  it { should delegate_method(:completed?).to(:project) }
  it { should delegate_method(:status).to(:project) }

  describe "price calculator" do
    it "#price_calculator" do
      print_job = build_stubbed(:print_job)
      expect(print_job.price_calculator).to be_an_instance_of(PriceCalculator::PrintJob)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_rush_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_rush_price).to(:price_calculator) }
  end

  describe "#brand" do
    it { should delegate_method(:brand_type).to(:brand) }
  end

  describe "brand is envisage" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(false)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:envisage_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:envisage_price)
      expect(print_job).to have_received(:rush_job?)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(true)
      allow(print_job).to receive(:brand_type).and_return('envisage')
      allow(print_job).to receive(:envisage_rush_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:envisage_rush_price)
      expect(print_job).to have_received(:rush_job?)
    end
  end
  
  describe "brand is envisage trade" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(false)
      allow(print_job).to receive(:brand_type).and_return('envisage_trade')
      allow(print_job).to receive(:envisage_trade_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:envisage_trade_price)
      expect(print_job).to have_received(:rush_job?)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(true)
      allow(print_job).to receive(:brand_type).and_return('envisage_trade')
      allow(print_job).to receive(:envisage_trade_rush_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:envisage_trade_rush_price)
      expect(print_job).to have_received(:rush_job?)
    end
  end

  describe "brand is my" do
    it "#brand_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(false)
      allow(print_job).to receive(:brand_type).and_return('my_office_branding')
      allow(print_job).to receive(:my_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:my_price)
      expect(print_job).to have_received(:rush_job?)
    end

    it "#brand_rush_job_price" do
      print_job = build_stubbed(:print_job)
      allow(print_job).to receive(:rush_job?).and_return(true)
      allow(print_job).to receive(:brand_type).and_return('my_office_branding')
      allow(print_job).to receive(:my_rush_price).and_return(0.0)

      print_job.brand_price

      expect(print_job).to have_received(:brand_type)
      expect(print_job).to have_received(:my_rush_price)
      expect(print_job).to have_received(:rush_job?)
    end

    it "#set_prices" do
      project = create(:quoted_project, rush_job: false)
      print_job = create(:print_job)
      allow(print_job).to receive(:envisage_price).and_return(25.00)
      allow(print_job).to receive(:envisage_trade_price).and_return(27.00)
      allow(print_job).to receive(:envisage_to_my_price).and_return(29.50)
      allow(print_job).to receive(:my_price).and_return(34.57)

      print_job.set_prices!

      expect(print_job).to have_received(:envisage_price)
      expect(print_job).to have_received(:envisage_trade_price)
      expect(print_job).to have_received(:envisage_to_my_price)
      expect(print_job).to have_received(:my_price)
      expect(print_job.envisage_sale_price).to eq(25.00)
      expect(print_job.envisage_trade_sale_price).to eq(27.00)
      expect(print_job.envisage_to_my_sale_price).to eq(29.50)
      expect(print_job.my_sale_price).to eq(34.57)
    end
  end
end
