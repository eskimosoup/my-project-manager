class ProjectPriceCalculator

  def initialize(print_jobs:, my_brand: true)
    @print_jobs = print_jobs
    @my_brand = my_brand
  end

  def brand_price
    @brand_price ||= sum_array(:brand_price)
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
    @envisage_to_my_price ||= sum_array(:envisage_to_my_price)
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

  attr_reader :print_jobs, :my_brand

  def sum_array(attr)
    print_jobs.map(&attr).reduce(:+)
  end

  def my_brand?
    my_brand == true
  end
end
