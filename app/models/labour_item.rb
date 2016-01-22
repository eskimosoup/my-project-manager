class LabourItem < ActiveRecord::Base
  belongs_to :labour
  belongs_to :print_job
  
  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :labour, presence: true
  validates :print_job, presence: true

  delegate :name, to: :labour
  delegate :quoted?, to: :print_job
  delegate :price, :total_cost, to: :price_calculator

  def price_calculator
    @price_calculator ||= LabourPriceCalculator.new(labour: labour, hours: hours)
  end

end
