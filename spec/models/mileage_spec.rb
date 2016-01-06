require 'rails_helper'

RSpec.describe Mileage, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:miles) }
    it { should validate_numericality_of(:miles).is_greater_than(0.0) }
    it { should validate_presence_of(:print_job) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end
end
