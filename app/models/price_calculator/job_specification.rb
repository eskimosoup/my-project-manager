class PriceCalculator::JobSpecification
  include PricingDefaults

  attr_reader :hours, :rate

  def initialize(hours:)
    @hours = hours
    @rate = BigDecimal("15")
  end

  def cost
    rate * hours
  end

  def envisage_price
    envisage_mark_up * cost
  end

  def envisage_trade_price
    envisage_trade_discount * envisage_price
  end

  def envisage_to_my_price
    envisage_to_my_discount * envisage_price
  end

  def my_price
    my_mark_up * envisage_to_my_price
  end

  def envisage_rush_price
    rush_job_mark_up * envisage_price
  end

  def envisage_trade_rush_price
    rush_job_mark_up * envisage_trade_price
  end

  def envisage_to_my_rush_price
    rush_job_mark_up * envisage_to_my_price
  end

  def my_rush_price
    rush_job_mark_up * my_price
  end

  private

  def envisage_mark_up
    BigDecimal("2.0")
  end

end
