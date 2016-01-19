require 'rails_helper'

RSpec.describe BrandAddress, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:postcode) }
  end

  describe "associations", :association do
    it { should belong_to(:brand) }
  end
end
