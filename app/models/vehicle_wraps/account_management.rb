class VehicleWraps::AccountManagement < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :account_management_rate, to: :brand, allow_nil: true
  delegate :price, :cost, to: :price_calculator

  def brand
    @brand ||= Brand.find_by(brand_type: Brand.brand_types[:my_vehicle_wrap])
  end

  def price_calculator
    @price_calculator ||= AccountManagementPriceCalculator.new(hours: hours, rate: account_management_rate)
  end
end
