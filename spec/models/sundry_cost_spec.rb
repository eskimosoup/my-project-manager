require 'rails_helper'

RSpec.describe SundryCost, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end
end
