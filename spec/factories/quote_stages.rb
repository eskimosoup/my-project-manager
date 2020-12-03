# == Schema Information
#
# Table name: quote_stages
#
#  id         :integer          not null, primary key
#  chance     :integer          not null
#  name       :string           not null
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :quote_stage do
    name 'Amber'
    chance 50
  end
end
