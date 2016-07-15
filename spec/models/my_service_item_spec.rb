require 'rails_helper'

RSpec.describe MyServiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than(0) }
    it { should validate_presence_of(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }
end
