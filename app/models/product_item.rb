class ProductItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :print_job

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :product, presence: true

  delegate :quoted?, to: :print_job
  delegate :name, to: :product
  delegate :variable_cost, :fixed_cost, :total_cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ProductPriceCalculator.new(product: product, area: area)
  end

end
