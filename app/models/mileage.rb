class Mileage < ActiveRecord::Base
  belongs_to :print_job

  delegate :price, :cost, to: :price_calculator

  validates :miles, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  def price_calculator
    @price_calculator ||= MileagePriceCalculator.new(miles: miles)
  end
end
