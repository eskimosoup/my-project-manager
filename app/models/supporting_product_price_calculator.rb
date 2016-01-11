class SupportingProductPriceCalculator

  attr_reader :supporting_product, :area
  delegate :mark_up, :substrate_cost, to: :supporting_product

  def initialize(supporting_product:, area:)
    @supporting_product = supporting_product
    @area = area
  end

  def cost
    (substrate_cost * area.to_d).round(2)
  end

  def price
    (cost * decimal_mark_up).round(2)
  end

  def decimal_mark_up
    mark_up.to_d / 100
  end

end
