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
class VehicleWraps::SundryItem < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :name, presence: true
  validates :vehicle_wrap, presence: true

  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::SundryItem.new(sundry_item: self)
  end
end
