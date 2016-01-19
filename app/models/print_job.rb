class PrintJob < ActiveRecord::Base

  include BrandPriceable

  belongs_to :project
  has_one :brand, through: :project
  has_many :account_managements
  has_many :designs
  has_many :job_specifications
  has_many :labour_items
  has_many :mileages
  has_many :product_items
  has_many :sundry_items
  has_many :supporting_product_items

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :project, presence: true

  delegate :brand_type, to: :brand
  delegate :cost_without_labour_or_printer, :cost_without_mileage, :cost,
    :price, :rush_job_price, :trade_price, :trade_rush_job_price, :my_price,
    :my_rush_job_price, :my_customer_price, :my_customer_rush_job_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PrintJobPriceCalculator.new(print_job: self)
  end

end
