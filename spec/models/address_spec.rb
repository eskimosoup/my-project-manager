require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:postcode) }
  end

  describe "associations", :association do
    it { should have_many(:brand_addresses) }
    it { should have_many(:brands).through(:brand_addresses) }
  end
end
