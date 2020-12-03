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
FactoryGirl.define do
  factory :supporting_product_cost do
    supporting_product nil
supporting_product_item nil
cost "9.99"
area "9.99"
  end

end
