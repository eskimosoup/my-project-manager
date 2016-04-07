class PrintJobPriceCalculator
  attr_reader :print_job
  delegate :job_specifications, :labour_items, :mileages, :product_items,
    :sundry_items, :supporting_product_items, :account_managements, :designs, to: :print_job
  delegate :cost, :fixed_cost, :variable_cost, :price, to: :product_item_total_calculator,
    prefix: "product_items"

  def initialize(print_job:)
    @print_job = print_job
  end

  def product_item_total_calculator
    @product_item_total_calculator ||= ProductItemTotalCalculator.new(product_items: product_items)
  end

  def rush_job_decimal_mark_up
    1.5.to_d
  end

  def cost_without_labour_or_printer
    cost - (labour_cost + product_items_fixed_cost)
  end

  def cost_without_mileage
    cost - mileage_cost
  end

  def cost
    [product_items_cost, supporting_product_items_cost, sundry_items_cost,
     job_specifications_cost, labour_cost, mileage_cost].reduce(:+)
  end

  def price
    price_without_mileage + mileage_price
  end

  def price_without_mileage_or_job_specs
    [product_items_price, supporting_product_items_price,
     labour_price, sundry_items_price].reduce(0, :+)
  end

  def price_without_mileage
    price_without_mileage_or_job_specs + job_specifications_price
  end

  def rush_job_price
    (price * rush_job_decimal_mark_up).round(2)
  end

  def trade_price
    trade_price_without_mileage + mileage_price
  end

  def trade_rush_job_price
    (trade_price_without_mileage * rush_job_decimal_mark_up).round(2) + mileage_price
  end

  def trade_price_without_mileage
    (price_without_mileage * 0.9).round(2)
  end
  private :trade_price_without_mileage

  def my_price
    (my_price_without_mileage + mileage_price).round(2)
  end

  def my_rush_job_price
    (my_price_without_mileage * rush_job_decimal_mark_up).round(2) + mileage_price
  end

  def my_customer_price
    my_customer_price_mark_up + mileage_price + 
      my_job_specifications_price + account_management_price + design_price
  end

  def my_customer_rush_job_price
    (( my_customer_price_mark_up + my_job_specifications_price) * rush_job_decimal_mark_up) +
      account_management_price + design_price + mileage_price
  end

  def my_customer_price_mark_up
    (my_price_without_mileage_or_job_specs * 1.4).round(2)
  end
  private :my_customer_price_mark_up

  def my_price_without_mileage
    (my_price_without_mileage_or_job_specs + my_job_specifications_price).round(2)
  end
  private :my_price_without_mileage

  def my_price_without_mileage_or_job_specs
    (price_without_mileage_or_job_specs * 0.8).round(2)
  end
  private :my_price_without_mileage_or_job_specs

  def my_job_specifications_price
    (job_specifications_price * 0.8).to_d
  end
  private :my_job_specifications_price

  # Account management

  def account_management_price
    account_managements.map(&:price).reduce(0, :+)
  end

  # Design
  
  def design_price
    designs.map(&:price).reduce(0, :+)
  end

  # Supporting items
  def supporting_product_items_cost
    supporting_product_items.map(&:cost).reduce(0, :+)
  end

  def supporting_product_items_price
    supporting_product_items.map(&:price).reduce(0, :+)
  end

  # Labour items
  def labour_cost
    labour_items.map(&:cost).reduce(0, :+)
  end

  def labour_price
    labour_items.map(&:price).reduce(0, :+)
  end

  # Sundry items
  def sundry_items_cost
    sundry_items.map(&:cost).reduce(0, :+)
  end

  def sundry_items_price
    sundry_items.map(&:price).reduce(0, :+)
  end

  # Job specifications
  def job_specifications_cost
    job_specifications.map(&:cost).reduce(0, :+)
  end

  def job_specifications_price
    job_specifications.map(&:price).reduce(0, :+)
  end

  # Mileage
  def mileage_cost
    mileages.map(&:cost).reduce(0, :+)
  end

  def mileage_price
    mileages.map(&:price).reduce(0, :+)
  end
end
