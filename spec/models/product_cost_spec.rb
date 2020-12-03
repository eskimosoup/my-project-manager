# == Schema Information
#
# Table name: product_costs
#
#  id            :integer          not null, primary key
#  area          :decimal(15, 3)   not null
#  fixed_cost    :decimal(10, 2)   not null
#  variable_cost :decimal(10, 2)   not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  print_job_id  :integer
#  product_id    :integer
#
# Indexes
#
#  index_product_costs_on_print_job_id  (print_job_id)
#  index_product_costs_on_product_id    (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#  fk_rails_...  (product_id => products.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe ProductCost, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:fixed_cost) }
    it { should validate_numericality_of(:fixed_cost).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:variable_cost) }
    it { should validate_numericality_of(:variable_cost).is_greater_than(0.0) }
    it { should validate_presence_of(:area) }
    it { should validate_numericality_of(:area).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:product) }
    it { should belong_to(:print_job) }
  end
end
