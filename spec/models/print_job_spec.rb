require 'rails_helper'

RSpec.describe PrintJob, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
    it { should validate_presence_of(:project) }
  end

  describe "associations", :association do
    it { should have_many(:job_specifications) }
    it { should have_many(:labour_items) }
    it { should belong_to(:project) }
    it { should have_many(:product_items) }
    it { should have_many(:sundry_items) }
    it { should have_many(:supporting_product_items) }
  end
end
