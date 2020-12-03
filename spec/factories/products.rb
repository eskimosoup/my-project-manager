# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  description    :text
#  hardware_cost  :decimal(5, 2)
#  ink_cost       :decimal(5, 2)
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  printer_cost   :decimal(5, 2)
#  substrate_cost :decimal(5, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
FactoryGirl.define do
  factory :product do
    sequence(:name){ |n| "Product #{ n }" }
    description "MyText"
    substrate_cost 9.99
    hardware_cost 9.99
    ink_cost 9.99
    printer_cost 9.99
    mark_up 300 
  end

end
