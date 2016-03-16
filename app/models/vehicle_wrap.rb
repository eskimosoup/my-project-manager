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
end
