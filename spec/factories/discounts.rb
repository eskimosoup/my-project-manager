# == Schema Information
#
# Table name: discounts
#
#  id          :integer          not null, primary key
#  amount      :decimal(10, 2)   not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer          not null
#
# Indexes
#
#  index_discounts_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :discount do
    project nil
    description "MyString"
    amount "9.99"
  end
end
