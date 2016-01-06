class ProductItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :print_job

  delegate :name, to: :product

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :product, presence: true

end
