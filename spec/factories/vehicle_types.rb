# == Schema Information
#
# Table name: vehicle_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_vehicle_types_on_name  (name) UNIQUE
#
FactoryGirl.define do
  factory :vehicle_type do
    name "MyString"
  end
end
