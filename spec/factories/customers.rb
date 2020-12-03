# == Schema Information
#
# Table name: customers
#
#  id               :integer          not null, primary key
#  amount_on_credit :decimal(7, 2)    default(0.0)
#  credit_limit     :decimal(7, 2)    default(0.0), not null
#  name             :string           not null
#  payment_days     :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_customers_on_name  (name) UNIQUE
#
FactoryGirl.define do
  factory :customer do
    sequence(:name) { |n| "Customer #{n}" }
    payment_days 0
    credit_limit 9.99
    amount_on_credit 9.99
  end
end
