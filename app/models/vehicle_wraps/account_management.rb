# == Schema Information
#
# Table name: vehicle_wraps_account_managements
#
#  id              :integer          not null, primary key
#  hours           :decimal(15, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vehicle_wrap_id :integer          not null
#
# Indexes
#
#  index_vehicle_wraps_account_managements_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
class VehicleWraps::AccountManagement < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :account_management_rate, to: :brand, allow_nil: true
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def brand
    @brand ||= Brand.find_by(brand_type: Brand.brand_types[:my_vehicle_wrap])
  end

  def price_calculator
    @price_calculator ||= PriceCalculator::AccountManagement.new(hours: hours, rate: account_management_rate)
  end
end
