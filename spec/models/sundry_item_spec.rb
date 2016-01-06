require 'rails_helper'

RSpec.describe SundryItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:print_job) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end
end
