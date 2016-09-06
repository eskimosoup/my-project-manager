FactoryGirl.define do
  factory :percentage_invoice do
    project nil
    name "Invoice name"
    amount "9.99"
    percentage 100
    paid false
    vat 20
    due_date { Date.today }
  end

  factory :amount_invoice do
    project nil
    name "Invoice name"
    amount 220
    vat_items_description "Something"
    vat_items_total 100
    non_vat_items_description "Something"
    non_vat_items_total 100
    paid false
    vat 20
    due_date { Date.today }
  end
end
