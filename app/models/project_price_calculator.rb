class ProjectPriceCalculator

  delegate :total_discount, :envisage_discount, :my_discount, to: :discount_assigner

  def initialize(print_jobs:, my_brand: true, discounts: [])
    @print_jobs = print_jobs
    @my_brand = my_brand
    @discounts = discounts
  end

  def brand_price
    brand_price_no_discount - total_discount
  end

  def brand_profit
    return nil unless brand_price.present?
    if my_brand?
      brand_price - envisage_to_my_price
    else
      brand_price - cost
    end
  end

  def envisage_to_my_price
    envisage_to_my_price_no_discount - envisage_discount
  end

  def envisage_profit
    return nil unless envisage_to_my_price.present?
    envisage_to_my_price - cost
  end

  def vat
    @vat ||= brand_price * 0.2
  end

  def brand_price_inc_vat
    brand_price + vat
  end

  def cost
    @cost ||= sum_array(:cost)
  end

  private

  attr_reader :print_jobs, :my_brand, :discounts

  def brand_price_no_discount
    @brand_price_no_discount ||= sum_array(:brand_price)
  end

  def envisage_to_my_price_no_discount
    @envisage_to_my_price_no_discount ||= sum_array(:envisage_to_my_price)
  end

  def sum_array(attr)
    print_jobs.map(&attr).reduce(0, :+)
  end

  def my_brand?
    my_brand == true
  end

  def discount_assigner
    @discount_assigner ||= DiscountAssigner.new(
      discounts: discounts,
      envisage_amount: envisage_to_my_price_no_discount,
      my_amount: brand_price_no_discount,
      cost: cost
    )
  end
end
