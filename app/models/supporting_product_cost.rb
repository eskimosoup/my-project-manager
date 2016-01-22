class SupportingProductCost < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  validates :print_job, presence: true
  validates :supporting_product, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0.0 }
  validates :area, presence: true, numericality: { greater_than: 0.0 }
end
