class DiscountAssigner
  def initialize(discounts:, envisage_amount:, my_amount:, cost:)
    @discounts = discounts
    @envisage_amount = envisage_amount
    @my_amount = my_amount
    @cost = cost
  end

  def total_discount
    discounts.map(&:amount).reduce(0, :+)
  end

  def envisage_discount
    envisage_share * total_discount
  end

  def my_discount
    my_share * total_discount
  end

  private

  attr_reader :discounts, :envisage_amount, :my_amount, :cost
  
  def envisage_profit_pre_discount
    (envisage_amount - cost).to_d
  end

  def my_profit_pre_discount
    (my_amount - envisage_amount).to_d
  end

  def total_profit_pre_discount
    my_amount - cost
  end

  def envisage_share
    envisage_profit_pre_discount / total_profit_pre_discount
  end

  def my_share
    my_profit_pre_discount / total_profit_pre_discount
  end

end
