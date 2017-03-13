class PriceCalculator::Project
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
      brand_price - envisage_to_my_price - my_service_cost
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

  def envisage_to_my_vat
    @envisage_to_my_vat ||= (envisage_to_my_vatable_price - envisage_discount) * 0.2
  end

  def vat
    @vat ||= begin
               calculated_vat = (vatable_price - total_discount) * 0.2
               return 0 if calculated_vat < 0
               calculated_vat
             end
  end

  def brand_price_inc_vat
    brand_price + vat
  end

  def cost
    @cost ||= sum_array(:cost)
  end

  def envisage_profit_without_labour
    envisage_to_my_price - envisage_cost_without_labour
  end

  def envisage_cost_without_labour
    cost - print_job_labour_costs
  end

  def print_job_labour_costs
    print_jobs.map { |x| x.labour_items.map(&:cost) }.flatten.sum
  end

  def profit
    profit = brand_profit + envisage_profit_without_labour
    profit.nan? ? 0 : profit
  end

  private

  attr_reader :print_jobs, :my_brand, :discounts

  def vatable_price
    @vatable_price ||= vatable_print_jobs.map(&:brand_price).reduce(0, :+)
  end

  def envisage_to_my_vatable_price
    @envisage_to_my_vatable_price ||= vatable_print_jobs.map(&:envisage_to_my_sale_price).reduce(0, :+)
  end

  def vatable_print_jobs
    print_jobs.select(&:vat?)
  end

  def brand_price_no_discount
    @brand_price_no_discount ||= sum_array(:brand_price)
  end

  def envisage_to_my_price_no_discount
    @envisage_to_my_price_no_discount ||= sum_array(:envisage_to_my_sale_price)
  end

  def my_service_cost
    return 0 unless my_brand?
    sum_array(:my_service_price)
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
