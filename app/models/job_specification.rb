class JobSpecification < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :cost, :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= JobSpecificationPriceCalculator.new(hours: hours)
  end
end
