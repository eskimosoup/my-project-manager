require "bigdecimal"

module PricingDefaults
  private
  def envisage_mark_up
    BigDecimal("1.2")
  end

  def my_mark_up
    BigDecimal("1.35")
  end

  def envisage_trade_discount
    BigDecimal("0.9")
  end

  def envisage_to_my_discount
    BigDecimal("0.8")
  end

  def rush_job_mark_up
    BigDecimal("1.5")
  end
end
