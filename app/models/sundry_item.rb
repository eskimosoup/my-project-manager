class SundryItem < ActiveRecord::Base
  belongs_to :print_job

  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :name, presence: true
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::SundryItem.new(sundry_item: self)
  end
end
