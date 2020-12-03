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
class ProductItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :print_job

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :product, presence: true

  delegate :quoted?, to: :print_job
  delegate :name, to: :product
  delegate :cost, to: :price_calculator
  delegate :fixed_cost, to: :price_calculator
  delegate :variable_cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::Product.new(product: product, area: area)
  end
end
