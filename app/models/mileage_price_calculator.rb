class MileagePriceCalculator

  attr_reader :miles

  def initialize(miles:)
    @miles = miles
  end

  def cost_per_mile
    0.40.to_d
  end

  def price
    (cost_per_mile * miles).round(2)
  end
  alias_method :cost, :price

end
