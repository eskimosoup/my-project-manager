class PrintJob < ActiveRecord::Base

  belongs_to :project
  has_one :brand, through: :project
  has_many :account_managements
  has_many :designs
  has_many :job_specifications
  has_many :labour_items
  has_many :mileages
  has_many :product_costs
  has_many :product_items
  has_many :sundry_costs
  has_many :sundry_items
  has_many :supporting_product_costs
  has_many :supporting_product_items

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :project, presence: true

  delegate :brand_type, to: :brand
  delegate :rush_job?, :status, :quoted?, :sold?, :completed?, to: :project
  delegate :cost_without_labour_or_printer, :cost_without_mileage, :cost,
    :price, :rush_job_price, :trade_price, :trade_rush_job_price, :my_price,
    :my_rush_job_price, :my_customer_price, :my_customer_rush_job_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PrintJobPriceCalculator.new(print_job: self)
  end

  def brand_price
    case brand_type
    when 'envisage'
      envisage_brand_price
    when 'envisage_trade'
      envisage_trade_brand_price
    when *Brand::MY_BRANDS
      my_brand_price
    end
  end

  def set_prices!
    update!(prices_hash)
  end

  def envisage_to_my_price
    if rush_job?
      my_rush_job_price
    else
      my_price
    end
  end

  private

  def envisage_brand_price
    return envisage_sale_price if envisage_sale_price.present?
    if rush_job?
      rush_job_price
    else
      price
    end
  end

  def envisage_trade_brand_price
    return envisage_trade_sale_price if envisage_trade_sale_price.present?
    if rush_job?
      trade_rush_job_price
    else
      trade_price
    end
  end

  def my_brand_price
    return my_sale_price if my_sale_price.present?
    if rush_job?
      my_customer_rush_job_price
    else
      my_customer_price
    end
  end

  def prices_hash
    {
      envisage_sale_price: price,
      envisage_trade_sale_price: trade_price,
      envisage_to_my_sale_price: my_price,
      my_sale_price: my_customer_price
    }
  end

end
