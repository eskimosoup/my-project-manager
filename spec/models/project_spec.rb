require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:brand) }
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
    it { should belong_to(:brand) }
    it { should belong_to(:shipping_address).class_name("Address") }
    it { should belong_to(:billing_address).class_name("Address") }
    it { should have_one(:business_address).through(:brand) }
    it { should have_many(:account_managements).through(:print_jobs) }
    it { should have_many(:designs).through(:print_jobs) }
    it { should have_many(:discounts) }
    it { should have_many(:invoices) }
    it { should have_many(:job_specifications).through(:print_jobs) }
    it { should have_many(:labour_items).through(:print_jobs) }
    it { should have_many(:mileages).through(:print_jobs) }
    it { should have_many(:print_jobs) }
    it { should have_many(:product_items).through(:print_jobs) }
    it { should have_many(:sundry_items).through(:print_jobs) }
    it { should have_many(:supporting_product_items).through(:print_jobs) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }

  describe "#brand" do
    it { should delegate_method(:logo).to(:brand) }
    it { should delegate_method(:name).to(:brand).with_prefix }
    it { should delegate_method(:colour).to(:brand) }
    it { should delegate_method(:my_brand?).to(:brand) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      project = build_stubbed(:project)

      expect(project.price_calculator).to be_an_instance_of(ProjectPriceCalculator)
    end

    it { should delegate_method(:vat).to(:price_calculator) }
    it { should delegate_method(:brand_price_inc_vat).to(:price_calculator) }
    it { should delegate_method(:brand_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:brand_profit).to(:price_calculator) }
    it { should delegate_method(:envisage_profit).to(:price_calculator) }
    it { should delegate_method(:cost).to(:price_calculator) }
  end
end
