require 'rails_helper'

RSpec.describe BrandAddress, type: :model do
  describe "associations", :association do
    it { should belong_to(:brand) }
    it { should belong_to(:address) }
  end
end
