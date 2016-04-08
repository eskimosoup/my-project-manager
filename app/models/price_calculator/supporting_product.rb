class PriceCalculator::SupportingProduct
  include PricingDefaults

  attr_reader :supporting_product, :area

  delegate :mark_up, to: :supporting_product
  delegate :substrate_cost, to: :supporting_product

  def initialize(supporting_product:, area:)
    @supporting_product = supporting_product
    @area = area
  end

  def cost
    area * substrate_cost
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
