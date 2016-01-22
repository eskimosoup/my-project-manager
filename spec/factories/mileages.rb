FactoryGirl.define do
  factory :mileage do
    sequence(:id){ |n| n }
    miles 9.99
    print_job
  end

end
