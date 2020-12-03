# == Schema Information
#
# Table name: my_service_items
#
#  id           :integer          not null, primary key
#  actual_cost  :decimal(10, 2)
#  cost         :decimal(15, 2)   not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_my_service_items_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
class MyServiceItem < ActiveRecord::Base
  belongs_to :print_job

  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
end
