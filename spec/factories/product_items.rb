# == Schema Information
#
# Table name: product_items
#
#  id           :integer          not null, primary key
#  actual_area  :decimal(15, 3)
#  actual_cost  :decimal(10, 2)
#  area         :decimal(15, 3)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer          not null
#  product_id   :integer          not null
#
# Indexes
#
#  index_product_items_on_print_job_id  (print_job_id)
#  index_product_items_on_product_id    (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#  fk_rails_...  (product_id => products.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :product_item do
    sequence(:id){ |n| n }
    area 5.50
    product
    print_job
  end

end
