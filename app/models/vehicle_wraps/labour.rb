class VehicleWraps::Labour < ActiveRecord::Base
  belongs_to :labour, class_name: "::Labour"
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :labour, presence: true
  validates :vehicle_wrap, presence: true

  delegate :name, to: :labour
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ::PriceCalculator::Labour.new(labour: labour, hours: hours)
  end
end
