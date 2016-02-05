class AccountManagement < ActiveRecord::Base
  belongs_to :print_job
  has_one :brand, through: :print_job

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :price, to: :price_calculator
  delegate :account_management_rate, to: :brand

  def price_calculator
    @price_calculator ||= AccountManagementPriceCalculator.new(hours: hours, rate: account_management_rate)
  end
end
