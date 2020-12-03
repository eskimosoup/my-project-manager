# == Schema Information
#
# Table name: vehicle_wraps_labours
#
#  id              :integer          not null, primary key
#  hours           :decimal(15, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  labour_id       :integer
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_labours_on_labour_id        (labour_id)
#  index_vehicle_wraps_labours_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (labour_id => labours.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe VehicleWraps::Labour, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:labour) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:labour).class_name("::Labour") }
    it { should belong_to(:vehicle_wrap) }
  end

  it { should delegate_method(:name).to(:labour) }

  describe "price calculator" do
    it "#price_calculator" do
      labour_item = build_stubbed(:vehicle_wraps_labour)
      expect(labour_item.price_calculator).to be_an_instance_of(PriceCalculator::Labour)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
  end
end
