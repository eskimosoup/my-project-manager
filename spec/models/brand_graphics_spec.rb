require "rails_helper"

describe BrandGraphics, type: :model do
  context "envisage" do
    it "self.klass_for" do
      expect(BrandGraphics.klass_for("envisage")).to eq(EnvisageBrandGraphics)
    end
  end

  context "envisage_trade" do
    it "self.klass_for" do
      expect(BrandGraphics.klass_for("envisage_trade")).to eq(EnvisageBrandGraphics)
    end
  end

  context "my_office_branding" do
    it "self.klass_for" do
      expect(BrandGraphics.klass_for("my_office_branding")).to eq(MyOfficeBrandGraphics)
    end
  end

  context "my_vehicle_wrap" do
    it "self.klass_for" do
      expect(BrandGraphics.klass_for("my_vehicle_wrap")).to eq(MyVehicleWrapBrandGraphics)
    end
  end
end
