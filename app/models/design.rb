class Design < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= DesignPriceCalculator.new(hours: hours)
  end
end
