class JobSpecification < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price
    envisage_price
  end

  def old_price_calculator
    @old_price_calculator ||= JobSpecificationPriceCalculator.new(hours: hours)
  end

  # TODO Clean Up

  def price_calculator
    @price_calculator ||= PriceCalculator::JobSpecification.new(hours: hours)
  end
end
