# == Schema Information
#
# Table name: supporting_products
#
#  id             :integer          not null, primary key
#  description    :text
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  substrate_cost :decimal(7, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_supporting_products_on_name  (name) UNIQUE
#
FactoryGirl.define do
  factory :supporting_product do
    name "MyString"
    description "MyText"
    substrate_cost "9.99"
    mark_up 100
  end

end
