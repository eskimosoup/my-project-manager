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
FactoryGirl.define do
  factory :sundry_item do
    sequence(:id){ |n| n }
    name "MyString"
    cost "9.99"
    print_job
  end

end
