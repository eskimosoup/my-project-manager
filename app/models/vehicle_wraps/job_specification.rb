class VehicleWraps::JobSpecification < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ::PriceCalculator::JobSpecification.new(hours: hours)
  end
end
