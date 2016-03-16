require 'rails_helper'

RSpec.describe VehicleType, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it do
      vehicle_type = build(:vehicle_type)
      expect(vehicle_type).to validate_uniqueness_of(:name)
    end
  end
end
