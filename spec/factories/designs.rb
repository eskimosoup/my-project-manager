FactoryGirl.define do
  factory :design do
    sequence(:id){ |n| n }
    print_job
    hours 5.50
  end

end
