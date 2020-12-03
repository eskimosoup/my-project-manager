# == Schema Information
#
# Table name: vehicle_wraps_materials
#
#  id              :integer          not null, primary key
#  area            :decimal(15, 3)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_materials_on_product_id       (product_id)
#  index_vehicle_wraps_materials_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
class VehicleWraps::Material < ActiveRecord::Base
  belongs_to :product
  belongs_to :vehicle_wrap

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :product, presence: true
  validates :vehicle_wrap, presence: true

  delegate :name, to: :product
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ::PriceCalculator::Product.new(product: product, area: area)
  end
end
