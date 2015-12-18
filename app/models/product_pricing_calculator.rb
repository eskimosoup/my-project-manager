class ProductPricingCalculator
  attr_reader :area, :product
  delegate :substrate_cost, :hardware_cost, :ink_cost, :printer_cost, to: :product, allow_nil: true

  def initialize(product:, area:)
    @product = product
    @area = area
  end

  def variable_cost
    [substrate_cost, hardware_cost, ink_cost].compact.reduce(:+)
  end

  def fixed_cost
    printer_cost || 0.0
  end

end
