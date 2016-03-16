class VehicleWraps::SundryItem < ActiveRecord::Base
  belongs_to :vehicle_wrap

  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :name, presence: true
  validates :vehicle_wrap, presence: true
end
