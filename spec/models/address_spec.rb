require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:postcode) }
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
  end
end
