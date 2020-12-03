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
class SupportingProductCost < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  validates :print_job, presence: true
  validates :supporting_product, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0.0 }
  validates :area, presence: true, numericality: { greater_than: 0.0 }
end
