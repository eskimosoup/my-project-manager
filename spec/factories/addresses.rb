FactoryGirl.define do
  factory :address do
    customer
    name "name"
    line_1 "MyString"
    line_2 "MyString"
    city "MyString"
    postcode "MyString"
  end

end
