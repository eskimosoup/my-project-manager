require 'rails_helper'

RSpec.describe AccountManagement, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
    it { should have_one(:brand).through(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }
  it { should delegate_method(:account_management_rate).to(:brand) }

  describe "price_calculator" do
    it "#price_calculator" do
      account_management = build_stubbed(:account_management)
      allow(account_management).to receive(:brand).and_return(build_stubbed(:brand))

      expect(account_management.price_calculator).to be_an_instance_of(AccountManagementPriceCalculator)
    end

    it { should delegate_method(:price).to(:price_calculator) }
  end
end
