class VehicleWraps::SupportingMaterial < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :vehicle_wrap

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :supporting_product, presence: true
  validates :vehicle_wrap, presence: true

  delegate :name, to: :supporting_product
  delegate :cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: area)
  end
end
