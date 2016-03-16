class VehicleWraps::JobSpecification < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :vehicle_wrap, presence: true
end
