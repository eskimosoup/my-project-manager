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
FactoryGirl.define do
  factory :labour_item do
    sequence(:id){ |n| n }
    print_job
    labour
    hours 5.0
  end

end
