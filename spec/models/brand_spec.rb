require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand_type) }
  end

  describe "associations", :association do
    it { should have_one(:brand_address) }
    it { should have_one(:address).through(:brand_address) }
  end

  describe "#logo" do
    it "envisage" do
      brand = build_stubbed(:envisage_brand)

      expect(brand.logo).to eq("logos/envisage.png")
    end

    it "envisage_trade" do
      brand = build_stubbed(:envisage_trade_brand)

      expect(brand.logo).to eq("logos/envisage.png")
    end

    it "my_office_branding" do
      brand = build_stubbed(:my_office_branding_brand)

      expect(brand.logo).to eq("logos/my-office-branding.jpg")
    end

    it "my_vehicle_wrap" do
      brand = build_stubbed(:my_vehicle_wrap_brand)

      expect(brand.logo).to eq("logos/my-vehicle-wrap.jpg")
    end
  end
end
