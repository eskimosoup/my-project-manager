require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:brand_type) }
    it { should validate_presence_of(:account_management_rate) }
    it { should validate_numericality_of(:account_management_rate).is_greater_than_or_equal_to(0.0) }
  end

  describe "associations", :association do
    it { should have_one(:brand_address) }
  end

  it { should delegate_method(:logo).to(:brand_graphics) }
  it { should delegate_method(:colour).to(:brand_graphics) }

  describe "#vehicle_brand?" do
    it "vehicle brand" do
      brand = build_stubbed(:my_vehicle_wrap_brand)

      expect(brand.vehicle_brand?).to eq(true)
    end

    it "non vehicle brand" do
      brand = build_stubbed(:envisage_brand)

      expect(brand.vehicle_brand?).to eq(false)
    end
  end

  describe "#brand_graphics" do
    it "envisage" do
      brand = build_stubbed(:envisage_brand)

      expect(brand.brand_graphics).to be_an_instance_of(EnvisageBrandGraphics)
    end

    it "envisage_trade" do
      brand = build_stubbed(:envisage_trade_brand)

      expect(brand.brand_graphics).to be_an_instance_of(EnvisageBrandGraphics)
    end

    it "my_office_branding" do
      brand = build_stubbed(:my_office_branding_brand)

      expect(brand.brand_graphics).to be_an_instance_of(MyOfficeBrandGraphics)
    end

    it "my_vehicle_wrap" do
      brand = build_stubbed(:my_vehicle_wrap_brand)

      expect(brand.brand_graphics).to be_an_instance_of(MyVehicleWrapBrandGraphics)
    end
  end

  describe "#my_brand?" do
    it "envisage" do
      brand = build_stubbed(:envisage_brand)

      expect(brand.my_brand?).to be false
    end

    it "envisage_trade" do
      brand = build_stubbed(:envisage_trade_brand)

      expect(brand.my_brand?).to be false
    end

    it "my_office_branding" do
      brand = build_stubbed(:my_office_branding_brand)

      expect(brand.my_brand?).to be true
    end

    it "my_vehicle_wrap" do
      brand = build_stubbed(:my_vehicle_wrap_brand)

      expect(brand.my_brand?).to be true
    end

  end

  context "my brand" do
    it "#prefix" do
      brand = Brand.new
      allow(brand).to receive(:my_brand?).and_return(true)

      expect(brand.prefix).to eq("MY")
    end
  end

  context "envisage brand" do
    it "#prefix" do
      brand = Brand.new
      allow(brand).to receive(:my_brand?).and_return(false)

      expect(brand.prefix).to eq("EN")
    end
  end
end
