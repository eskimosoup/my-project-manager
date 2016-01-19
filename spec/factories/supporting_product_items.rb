FactoryGirl.define do
  factory :supporting_product_item do
    sequence(:id){ |n| n }
    area 9.99
    supporting_product
    print_job
  end

end
