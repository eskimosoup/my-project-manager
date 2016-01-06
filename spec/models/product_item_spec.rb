require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:product) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
    it { should belong_to(:product) }
  end

  describe "delegations", :delegation do
    it { should delegate_method(:name).to(:product) }
  end
end
