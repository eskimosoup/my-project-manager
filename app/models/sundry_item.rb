# == Schema Information
#
# Table name: sundry_items
#
#  id           :integer          not null, primary key
#  actual_cost  :decimal(10, 2)
#  cost         :decimal(15, 2)   not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer          not null
#
# Indexes
#
#  index_sundry_items_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class SundryItem < ActiveRecord::Base
  belongs_to :print_job

  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :name, presence: true
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :envisage_price, to: :price_calculator
  delegate :envisage_trade_price, to: :price_calculator
  delegate :envisage_to_my_price, to: :price_calculator
  delegate :my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::SundryItem.new(sundry_item: self)
  end
end
