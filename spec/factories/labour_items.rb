FactoryGirl.define do
  factory :labour_item do
    sequence(:id){ |n| n }
    print_job
    labour
    hours 5.0
  end

end
