FactoryGirl.define do
  factory :invoice do
    project nil
    name "Invoice name"
    amount "9.99"
    percentage 100
    paid false
    vat 20
    due_date { Date.today }
  end
end
