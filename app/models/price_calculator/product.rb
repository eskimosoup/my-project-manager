class PriceCalculator::Product
  include PricingDefaults

  attr_reader :product, :area
  delegate :substrate_cost, to: :product
  delegate :hardware_cost, to: :product, allow_nil: true
  delegate :ink_cost, to: :product, allow_nil: true
  delegate :printer_cost, to: :product, allow_nil: true
  delegate :mark_up, to: :product, allow_nil: true

  def initialize(product:, area:)
    @product = product
    @area = area
  end

  def variable_cost
    variable_costs_per_square_metre * area
  end

  def fixed_cost
    return 0 if printer_cost.blank?
    area * printer_cost
  end

  def cost
    variable_cost + fixed_cost
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

  def variable_costs_per_square_metre
    [substrate_cost, hardware_cost, ink_cost].compact.reduce(:+)
  end

  def envisage_mark_up
    mark_up.to_d / 100
  end
end
