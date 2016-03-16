require 'rails_helper'

RSpec.describe VehicleWraps::AccountManagement, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:vehicle_wrap) }
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_wrap) }
  end
end
