require 'rails_helper'

RSpec.describe VehicleWraps::Material, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:vehicle_wrap) }
  end

  describe "associations", :association do
    it { should belong_to(:product) }
    it { should belong_to(:vehicle_wrap) }
  end

  it { should delegate_method(:name).to(:product) }
end
