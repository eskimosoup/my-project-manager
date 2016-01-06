class SupportingProductItem < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  delegate :name, to: :supporting_product

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :supporting_product, presence: true
end
