FactoryGirl.define do
  factory :account_management do
    sequence(:id){ |n| n }
    print_job
    hours 4.50
  end

end
