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
class SupportingProductItem < ActiveRecord::Base
  belongs_to :supporting_product
  belongs_to :print_job

  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
  validates :supporting_product, presence: true

  delegate :quoted?, to: :print_job
  delegate :name, to: :supporting_product
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::SupportingProduct.new(supporting_product: supporting_product, area: area)
  end
end
