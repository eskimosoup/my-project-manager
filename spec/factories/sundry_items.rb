FactoryGirl.define do
  factory :sundry_item do
    sequence(:id){ |n| n }
    name "MyString"
    cost "9.99"
    print_job
  end

end
