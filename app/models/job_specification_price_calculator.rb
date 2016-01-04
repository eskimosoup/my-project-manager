class JobSpecificationPriceCalculator

  attr_reader :hours

  def initialize(hours:)
    @hours = hours
  end

  def cost_per_hour
    15.00.to_d
  end

  def price
    (cost_per_hour * hours).round(2)
  end
  alias_method :cost, :price
end
