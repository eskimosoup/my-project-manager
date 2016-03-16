require 'rails_helper'

RSpec.describe VehicleWrap, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:vehicle_type) }
    it { should validate_presence_of(:description) }
  end

  describe "associations", :association do
    it { should belong_to(:vehicle_type) }
    it { should have_many(:materials).class_name("VehicleWraps::Material") }
    it { should have_many(:supporting_materials).class_name("VehicleWraps::SupportingMaterial") }
    it { should have_many(:labours).class_name("VehicleWraps::Labour") }
    it { should have_many(:sundry_items).class_name("VehicleWraps::SundryItem") }
    it { should have_many(:job_specifications).class_name("VehicleWraps::JobSpecification") }
    it { should have_many(:mileages).class_name("VehicleWraps::Mileage") }
    it { should have_many(:account_managements).class_name("VehicleWraps::AccountManagement") }
  end

  it { should delegate_method(:name).to(:vehicle_type).with_prefix }
end
