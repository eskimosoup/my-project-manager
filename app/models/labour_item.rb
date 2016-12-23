class LabourItem < ActiveRecord::Base
  belongs_to :labour
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :labour, presence: true
  validates :print_job, presence: true

  delegate :name, to: :labour
  delegate :quoted?, to: :print_job
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  before_save :set_actual_cost, if: proc { |x| x.actual_hours.present? && x.actual_cost.blank? }

  def set_actual_cost
    self.actual_cost = actual_hours * labour.per_hour
  end

  def price_calculator
    @price_calculator ||= PriceCalculator::Labour.new(labour: labour, hours: hours)
  end
end
