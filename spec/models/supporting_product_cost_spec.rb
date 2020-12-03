# == Schema Information
#
# Table name: supporting_product_costs
#
#  id                    :integer          not null, primary key
#  area                  :decimal(15, 3)   not null
#  cost                  :decimal(15, 2)   not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  print_job_id          :integer
#  supporting_product_id :integer
#
# Indexes
#
#  index_supporting_product_costs_on_print_job_id           (print_job_id)
#  index_supporting_product_costs_on_supporting_product_id  (supporting_product_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#  fk_rails_...  (supporting_product_id => supporting_products.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe SupportingProductCost, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:supporting_product) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than(0.0) }
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:supporting_product) }
    it { should belong_to(:print_job) }
  end
end
