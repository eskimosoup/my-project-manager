class AccountManagement < ActiveRecord::Base
  # TODO Clean Up
  belongs_to :print_job
  has_one :brand, through: :print_job

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :account_management_rate, to: :brand
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price
    price_calculator.envisage_price
  end

  def old_price_calculator
    @old_price_calculator ||= AccountManagementPriceCalculator.new(hours: hours, rate: account_management_rate)
  end

  def price_calculator
    @price_calculator ||= PriceCalculator::AccountManagement.new(hours: hours, rate: account_management_rate)
  end
end
