FactoryGirl.define do
  factory :envisage_invoice, class: "Envisage::Invoice" do
    project nil
    name "MyString"
    percentage 1
    amount "9.99"
    vat "9.99"
    paid false
  end
end
