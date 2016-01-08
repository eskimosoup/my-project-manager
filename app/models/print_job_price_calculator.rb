class PrintJobPriceCalculator
  attr_reader :print_job
  delegate :job_specifications, :labour_items, :mileages, :product_items,
    :sundry_items, :supporting_product_items, to: :print_job

  def initialize(print_job:)
    @print_job = print_job
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

  def price_without_mileage
    [product_items_price, supporting_product_items_price, labour_price,
     sundry_items_price, job_specifications_price].reduce(0, :+)
  end

  def rush_job_price
    (price * 1.5).round(2)
  end

  def trade_price
    trade_price_without_mileage + mileage_price
  end

  def trade_rush_job_price
    (trade_price_without_mileage * 1.5).round(2) + mileage_price
  end

  def trade_price_without_mileage
    (price_without_mileage * 0.9).round(2)
  end
  private :trade_price_without_mileage

  def my_price
    my_price_without_mileage + mileage_price
  end

  def my_rush_job_price
    (my_price_without_mileage * 1.5).round(2) + mileage_price
  end

  def my_price_without_mileage
    (price_without_mileage * 0.8).round(2)
  end
  private :my_price_without_mileage

  # Product Items
  def product_items_cost
    product_items.map(&:cost).reduce(0, :+)
  end

  def product_items_fixed_cost
    product_items.map(&:fixed_cost).reduce(0, :+)
  end

  def product_items_variable_cost
    product_items.map(&:variable_cost).reduce(0, :+)
  end

  def product_items_price
    product_items.map(&:price).reduce(0, :+)
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
