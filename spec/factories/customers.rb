FactoryGirl.define do
  factory :customer do
    sequence(:name) { |n| "Customer #{n}" }
    credit_limit 9.99
    amount_on_credit 9.99
  end
end
