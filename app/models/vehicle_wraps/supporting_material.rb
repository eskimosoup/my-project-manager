# == Schema Information
#
# Table name: vehicle_wraps_supporting_materials
#
#  id                    :integer          not null, primary key
#  area                  :decimal(15, 3)   not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  supporting_product_id :integer
#  vehicle_wrap_id       :integer
#
# Indexes
#
#  supporting_product_supporting_materials  (supporting_product_id)
#  vehicle_wrap_supporting materials        (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (supporting_product_id => supporting_products.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
class VehicleWraps::SupportingMaterial < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :vehicle_wrap

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :supporting_product, presence: true
  validates :vehicle_wrap, presence: true

  delegate :name, to: :supporting_product
  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ::PriceCalculator::SupportingProduct.new(supporting_product: supporting_product, area: area)
  end
end
