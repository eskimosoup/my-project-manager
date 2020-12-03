# == Schema Information
#
# Table name: mileage_costs
#
#  id           :integer          not null, primary key
#  cost         :decimal(15, 2)   not null
#  miles        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_mileage_costs_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class MileageCost < ActiveRecord::Base
  belongs_to :print_job
  validates :miles, presence: true
end
