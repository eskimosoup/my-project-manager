# == Schema Information
#
# Table name: vehicle_wraps_job_specifications
#
#  id              :integer          not null, primary key
#  hours           :decimal(15, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_job_specifications_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
class VehicleWraps::JobSpecification < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :vehicle_wrap, presence: true

  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ::PriceCalculator::JobSpecification.new(hours: hours)
  end
end
