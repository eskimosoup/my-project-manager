class SupportingProductItem < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :supporting_product, presence: true

  delegate :quoted?, to: :print_job
  delegate :name, to: :supporting_product
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::SupportingProduct.new(supporting_product: supporting_product, area: area)
  end
end
