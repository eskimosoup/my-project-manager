class PriceCalculator::Mileage
  include PricingDefaults

  attr_reader :miles

  def initialize(miles:)
    @miles = miles
  end

  def cost
    cost_per_mile * miles
  end
  alias_method :envisage_price, :cost
  alias_method :envisage_trade_price, :cost
  alias_method :envisage_to_my_price, :cost
  alias_method :my_price, :cost
  alias_method :envisage_rush_price, :cost
  alias_method :envisage_trade_rush_price, :cost
  alias_method :envisage_to_my_rush_price, :cost
  alias_method :my_rush_price, :cost
  
  private

  def cost_per_mile
    BigDecimal("0.4")
  end
end
