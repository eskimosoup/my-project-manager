class PriceCalculator::Labour
  include PricingDefaults

  attr_reader :labour, :hours

  delegate :per_hour, to: :labour
  delegate :mark_up, to: :labour

  def initialize(labour:, hours:)
    @labour = labour
    @hours = hours
  end

  def cost
    hours * per_hour
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
    mark_up.to_d / 100
  end
end
