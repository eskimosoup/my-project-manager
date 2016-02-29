require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:amount) }
  end

  describe "associations", :association do
    it { should belong_to(:project) }
  end
end
