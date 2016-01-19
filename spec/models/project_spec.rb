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
    it { should have_many(:print_jobs) }
  end

  describe "#brand" do
    it { should delegate_method(:brand_type).to(:brand) }
    it { should delegate_method(:logo).to(:brand) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      project = build_stubbed(:project)

      expect(project.price_calculator).to be_an_instance_of(ProjectPriceCalculator)
    end

    it { should delegate_method(:price).to(:price_calculator) }
    it { should delegate_method(:rush_job_price).to(:price_calculator) }
    it { should delegate_method(:trade_price).to(:price_calculator) }
    it { should delegate_method(:trade_rush_job_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_job_price).to(:price_calculator) }
    it { should delegate_method(:my_customer_price).to(:price_calculator) }
    it { should delegate_method(:my_customer_rush_job_price).to(:price_calculator) }
  end
end
