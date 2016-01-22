FactoryGirl.define do
  factory :job_specification do
    sequence(:id){ |n| n }
    hours "9.99"
    print_job
  end

end
