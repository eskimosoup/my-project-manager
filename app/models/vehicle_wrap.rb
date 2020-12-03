# == Schema Information
#
# Table name: vehicle_wraps
#
#  id                            :integer          not null, primary key
#  description                   :text             not null
#  envisage_override_price       :decimal(10, 2)
#  envisage_to_my_override_price :decimal(10, 2)
#  envisage_trade_override_price :decimal(10, 2)
#  my_override_price             :decimal(10, 2)
#  name                          :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  vehicle_type_id               :integer
#
# Indexes
#
#  index_vehicle_wraps_on_vehicle_type_id  (vehicle_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_type_id => vehicle_types.id) ON DELETE => cascade
#
class VehicleWrap < ActiveRecord::Base
  belongs_to :vehicle_type
  has_many :account_managements, class_name: "VehicleWraps::AccountManagement"
  has_many :designs, class_name: "VehicleWraps::Design"
  has_many :job_specifications, class_name: "VehicleWraps::JobSpecification"
  has_many :labours, class_name: "VehicleWraps::Labour"
  has_many :materials, class_name: "VehicleWraps::Material"
  has_many :mileages, class_name: "VehicleWraps::Mileage"
  has_many :sundry_items, class_name: "VehicleWraps::SundryItem"
  has_many :supporting_materials, class_name: "VehicleWraps::SupportingMaterial"

  validates :description, presence: true
  validates :name, presence: true
  validates :vehicle_type, presence: true

  delegate :name, to: :vehicle_type, prefix: true

  delegate :cost, to: :price_calculator
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::VehicleWrap.new(vehicle_wrap: self)
  end
end
