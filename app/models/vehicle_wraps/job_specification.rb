class VehicleWraps::JobSpecification < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= JobSpecificationPriceCalculator.new(hours: hours)
  end
end
