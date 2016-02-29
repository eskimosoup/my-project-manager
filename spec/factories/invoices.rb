FactoryGirl.define do
  factory :invoice do
    project nil
    slug "MyString"
    amount "9.99"
    paid false
  end
end
