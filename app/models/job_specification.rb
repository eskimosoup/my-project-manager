# == Schema Information
#
# Table name: job_specifications
#
#  id           :integer          not null, primary key
#  actual_hours :decimal(15, 2)
#  hours        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_job_specifications_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class JobSpecification < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::JobSpecification.new(hours: hours)
  end
end
