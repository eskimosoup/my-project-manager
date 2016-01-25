require 'rails_helper'

RSpec.describe MileageCost, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:miles) }
  end
end
