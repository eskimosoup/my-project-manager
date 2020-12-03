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
FactoryGirl.define do
  factory :my_service_item do
    name "MyString"
    cost "9.99"
    print_job nil
  end
end
