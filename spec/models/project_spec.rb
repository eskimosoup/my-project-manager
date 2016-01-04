require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:brand) }
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
    it { should belong_to(:brand) }
  end
end
