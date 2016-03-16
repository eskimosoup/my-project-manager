class VehicleType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
