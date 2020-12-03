# == Schema Information
#
# Table name: account_managements
#
#  id           :integer          not null, primary key
#  actual_hours :decimal(15, 2)
#  hours        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer          not null
#
# Indexes
#
#  index_account_managements_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class AccountManagement < ActiveRecord::Base
  belongs_to :print_job
  has_one :brand, through: :print_job

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
  delegate :account_management_rate, to: :brand
  delegate :cost, to: :price_calculator
  delegate :envisage_price, :envisage_rush_price, to: :price_calculator
  delegate :envisage_trade_price, :envisage_trade_rush_price, to: :price_calculator
  delegate :envisage_to_my_price, :envisage_to_my_rush_price, to: :price_calculator
  delegate :my_price, :my_rush_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= PriceCalculator::AccountManagement.new(hours: hours, rate: account_management_rate)
  end
end
