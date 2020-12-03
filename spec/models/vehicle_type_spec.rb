# == Schema Information
#
# Table name: vehicle_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_vehicle_types_on_name  (name) UNIQUE
#
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
