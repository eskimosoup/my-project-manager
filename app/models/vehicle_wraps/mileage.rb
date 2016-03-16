class VehicleWraps::Mileage < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :miles, presence: true, numericality: { greater_than: 0.0 }
  validates :vehicle_wrap, presence: true
end
