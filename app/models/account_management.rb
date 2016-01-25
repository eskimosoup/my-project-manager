class AccountManagement < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= AccountManagementPriceCalculator.new(hours: hours)
  end
end
