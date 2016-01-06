class JobSpecificationPriceCalculator

  attr_reader :hours

  def initialize(hours:)
    @hours = hours
  end

  def cost_per_hour
    15.00.to_d
  end

  def decimal_mark_up
    2.0.to_d
  end

  def cost
    (cost_per_hour * hours).round(2)
  end

  def price
    (cost * decimal_mark_up).round(2)
  end
end
