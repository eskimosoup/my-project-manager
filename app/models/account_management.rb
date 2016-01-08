class AccountManagement < ActiveRecord::Base
  belongs_to :project

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :project, presence: true

  delegate :price, to: :price_calculator

  def price_calculator
    @price_calculator ||= AccountManagementPriceCalculator.new(hours: hours)
  end
end
