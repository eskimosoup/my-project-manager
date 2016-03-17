class VehicleWraps::Material < ActiveRecord::Base
  belongs_to :product
  belongs_to :vehicle_wrap

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :product, presence: true
  validates :vehicle_wrap, presence: true

  delegate :name, to: :product
  delegate :variable_cost, :fixed_cost, :cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ProductPriceCalculator.new(product: product, area: area)
  end
end
