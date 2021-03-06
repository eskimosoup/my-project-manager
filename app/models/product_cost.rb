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
class ProductCost < ActiveRecord::Base
  belongs_to :product
  belongs_to :print_job

  validates :product, presence: true
  validates :print_job, presence: true
  validates :variable_cost, presence: true, numericality: { greater_than: 0.0 }
  validates :fixed_cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :area, presence: true, numericality: { greater_than: 0.0 }
end
