# == Schema Information
#
# Table name: supporting_product_items
#
#  id                    :integer          not null, primary key
#  actual_area           :decimal(15, 3)
#  actual_cost           :decimal(10, 2)
#  area                  :decimal(15, 3)   not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  print_job_id          :integer          not null
#  supporting_product_id :integer          not null
#
# Indexes
#
#  index_supporting_product_items_on_print_job_id           (print_job_id)
#  index_supporting_product_items_on_supporting_product_id  (supporting_product_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#  fk_rails_...  (supporting_product_id => supporting_products.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :supporting_product_item do
    sequence(:id){ |n| n }
    area 9.99
    supporting_product
    print_job
  end

end
