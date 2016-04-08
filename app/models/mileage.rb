class Mileage < ActiveRecord::Base
  belongs_to :print_job

  validates :miles, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator
  delegate :quoted?, to: :print_job

  def price_calculator
    @price_calculator ||= PriceCalculator::Mileage.new(miles: miles)
  end
end
