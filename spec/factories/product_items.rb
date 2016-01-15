FactoryGirl.define do
  factory :product_item do
    sequence(:id){ |n| n }
    area 5.50
    product
    print_job
  end

end
