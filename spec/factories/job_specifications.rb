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
FactoryGirl.define do
  factory :job_specification do
    sequence(:id){ |n| n }
    hours "9.99"
    print_job
  end

end
