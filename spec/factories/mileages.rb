# == Schema Information
#
# Table name: mileages
#
#  id           :integer          not null, primary key
#  actual_miles :decimal(15, 2)
#  miles        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_mileages_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :mileage do
    sequence(:id){ |n| n }
    miles 9.99
    print_job
  end

end
