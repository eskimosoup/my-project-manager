# == Schema Information
#
# Table name: vehicle_wraps_sundry_items
#
#  id              :integer          not null, primary key
#  cost            :decimal(15, 2)   not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_sundry_items_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe VehicleWraps::SundryItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "assocations", :association do
    it { should belong_to(:vehicle_wrap) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      sundry_item = build_stubbed(:sundry_item)
      expect(sundry_item.price_calculator).to be_an_instance_of(PriceCalculator::SundryItem)
    end

    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
  end
end
