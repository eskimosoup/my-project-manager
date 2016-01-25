class ProductCost < ActiveRecord::Base
  belongs_to :product
  belongs_to :print_job

  validates :product, presence: true
  validates :print_job, presence: true
  validates :variable_cost, presence: true, numericality: { greater_than: 0.0 }
  validates :fixed_cost, presence: true, numericality: { greater_than: 0.0 }
  validates :area, presence: true, numericality: { greater_than: 0.0 }
end
