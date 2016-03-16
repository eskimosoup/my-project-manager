class VehicleWrap < ActiveRecord::Base
  belongs_to :vehicle_type
  has_many :materials, class_name: "VehicleWraps::Material"
  has_many :supporting_materials, class_name: "VehicleWraps::SupportingMaterial"
  has_many :labours, class_name: "VehicleWraps::Labour"

  validates :description, presence: true
  validates :name, presence: true
  validates :vehicle_type, presence: true

  delegate :name, to: :vehicle_type, prefix: true
end
