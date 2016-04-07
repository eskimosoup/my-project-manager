class PriceCalculator::Design
  include PricingDefaults

  attr_reader :hours, :rate
  
  def initialize(hours: )
    @hours = hours
    @rate = BigDecimal("65")
  end

  def cost
    0
  end

  # account management is purely on my projects
  def envisage_price
    0
  end
  alias_method :envisage_trade_price, :envisage_price
  alias_method :envisage_to_my_price, :envisage_price

  def envisage_rush_price
    0
  end
  alias_method :envisage_trade_rush_price, :envisage_rush_price
  alias_method :envisage_to_my_rush_price, :envisage_rush_price

  def my_price
    rate * hours
  end

  def my_rush_price
    rush_job_mark_up * my_price
  end
end
