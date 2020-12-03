# == Schema Information
#
# Table name: sundry_costs
#
#  id           :integer          not null, primary key
#  cost         :decimal(15, 2)   not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_sundry_costs_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class SundryCost < ActiveRecord::Base
  belongs_to :print_job

  validates :cost, presence: true, numericality: { greater_than: 0.0 }
  validates :name, presence: true
  validates :print_job, presence: true
end
