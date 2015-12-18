require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
    it { should have_many(:project_items) }
  end
end
