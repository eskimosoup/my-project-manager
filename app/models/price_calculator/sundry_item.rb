class PriceCalculator::SundryItem
  include PricingDefaults

  attr_reader :sundry_item
  delegate :cost, to: :sundry_item

  def initialize(sundry_item:)
    @sundry_item = sundry_item
  end

  def envisage_price
    envisage_mark_up * cost
  end
  alias_method :envisage_trade_price, :envisage_price
  alias_method :envisage_to_my_price, :envisage_price

  def envisage_rush_price
    rush_job_mark_up * envisage_price
  end
  alias_method :envisage_trade_rush_price, :envisage_rush_price
  alias_method :envisage_to_my_rush_price, :envisage_rush_price

  def my_price
    (my_mark_up * envisage_to_my_price).round(2)
  end

  def my_rush_price
    (rush_job_mark_up * my_price).round(2)
  end

  private

  def my_mark_up
    BigDecimal("1.16666666667")
  end
end
