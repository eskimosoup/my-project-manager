class Mileage < ActiveRecord::Base
  belongs_to :print_job

  validates :miles, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator
  delegate :quoted?, to: :print_job

  def price
    envisage_price
  end

  def old_price_calculator
    @old_price_calculator ||= MileagePriceCalculator.new(miles: miles)
  end

  # TODO Clean Up

  def price_calculator
    @price_calculator ||= PriceCalculator::Mileage.new(miles: miles)
  end
end
