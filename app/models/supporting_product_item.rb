class SupportingProductItem < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :supporting_product, presence: true

  delegate :name, to: :supporting_product
  delegate :cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= SupportingProductPriceCalculator.new(supporting_product: supporting_product, area: area)
  end

end
