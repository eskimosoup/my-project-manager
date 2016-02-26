require 'rails_helper'

RSpec.describe ProductCost, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:fixed_cost) }
    it { should validate_numericality_of(:fixed_cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:variable_cost) }
    it { should validate_numericality_of(:variable_cost).is_greater_than(0.0) }
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:product) }
    it { should belong_to(:print_job) }
  end
end
