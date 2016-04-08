require 'rails_helper'

RSpec.describe VehicleWraps::AccountManagement, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:vehicle_wrap) }
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_wrap) }
  end

  it "#brand" do
    brand = create(:my_vehicle_wrap_brand)
    account_management = VehicleWraps::AccountManagement.new

    expect(account_management.brand).to eq(brand)
  end
  it { should delegate_method(:account_management_rate).to(:brand) }

  describe "price_calculator" do
    it "#price_calculator" do
      account_management = build_stubbed(:vehicle_wraps_account_management)
      allow(account_management).to receive(:brand).and_return(build_stubbed(:brand))

      expect(account_management.price_calculator).to be_an_instance_of(PriceCalculator::AccountManagement)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
