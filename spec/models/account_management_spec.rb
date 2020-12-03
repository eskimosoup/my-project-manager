# == Schema Information
#
# Table name: account_managements
#
#  id           :integer          not null, primary key
#  actual_hours :decimal(15, 2)
#  hours        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer          not null
#
# Indexes
#
#  index_account_managements_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
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

      expect(account_management.price_calculator).to be_an_instance_of(PriceCalculator::AccountManagement)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:envisage_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_rush_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_price).to(:price_calculator) }
  end
end
