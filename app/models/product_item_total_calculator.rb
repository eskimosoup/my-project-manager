class ProductItemTotalCalculator

  attr_reader :product_items

  def initialize(product_items:)
    @product_items = product_items
  end
  
  def cost
    sum_attrs(:cost)
  end

  def fixed_cost
    sum_attrs(:fixed_cost)
  end

  def variable_cost
    sum_attrs(:variable_cost)
  end

  def price
    sum_attrs(:price)
  end

  private

  def sum_attrs(attribute)
    product_items.map(&attribute).reduce(0, :+)
  end
end
