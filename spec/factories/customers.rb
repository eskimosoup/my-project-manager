FactoryGirl.define do
  factory :customer do
    sequence(:name) { |n| "Customer #{n}" }
    payment_days 0
    credit_limit 9.99
    amount_on_credit 9.99
  end
end
