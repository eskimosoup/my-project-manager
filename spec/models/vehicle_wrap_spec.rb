require 'rails_helper'

RSpec.describe VehicleWrap, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:vehicle_type) }
    it { should validate_presence_of(:description) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_type) }
  end

  it { should delegate_method(:name).to(:vehicle_type).with_prefix }
end
