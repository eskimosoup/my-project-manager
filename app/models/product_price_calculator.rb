class ProductPriceCalculator
  attr_reader :area, :product
  delegate :substrate_cost, :hardware_cost, :ink_cost, :printer_cost, :mark_up,
    to: :product, allow_nil: true

  def initialize(product:, area:)
    @product = product
    @area = area
  end

  def variable_cost
    cost = [substrate_cost, hardware_cost, ink_cost].compact.reduce(:+) * area.to_d
    cost.round(2)
  end

  def fixed_cost
    cost = (printer_cost || 0.0) * area.to_d
    cost.round(2)
  end

  def cost
    (variable_cost + fixed_cost).round(2)
  end

  def price
    (cost * decimal_mark_up).round(2)
  end

  def decimal_mark_up
    mark_up.to_d / 100
  end

end
