class VehicleWraps::Design < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :price, :cost, to: :price_calculator

  def price_calculator
    @price_calculator ||= DesignPriceCalculator.new(hours: hours)
  end
end
