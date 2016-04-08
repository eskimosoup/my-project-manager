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
