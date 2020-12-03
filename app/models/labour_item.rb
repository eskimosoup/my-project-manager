# == Schema Information
#
# Table name: labour_items
#
#  id           :integer          not null, primary key
#  actual_cost  :decimal(10, 2)
#  actual_hours :decimal(15, 2)
#  hours        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  labour_id    :integer          not null
#  print_job_id :integer          not null
#
# Indexes
#
#  index_labour_items_on_labour_id     (labour_id)
#  index_labour_items_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (labour_id => labours.id) ON DELETE => cascade
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class LabourItem < ActiveRecord::Base
  belongs_to :labour
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :labour, presence: true
  validates :print_job, presence: true

  delegate :name, to: :labour
  delegate :quoted?, to: :print_job
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  before_save :set_actual_cost, if: proc { |x| x.actual_hours.present? && x.actual_cost.blank? }

  def set_actual_cost
    self.actual_cost = actual_hours * labour.per_hour
  end

  def price_calculator
    @price_calculator ||= PriceCalculator::Labour.new(labour: labour, hours: hours)
  end
end
