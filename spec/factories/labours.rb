# == Schema Information
#
# Table name: labours
#
#  id          :integer          not null, primary key
#  description :text
#  mark_up     :integer          default(100), not null
#  name        :string           not null
#  per_hour    :decimal(5, 2)    not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_labours_on_name  (name) UNIQUE
#
FactoryGirl.define do
  factory :labour do
    name "MyString"
    description "MyText"
    per_hour "9.99"
    mark_up 120
  end

end
