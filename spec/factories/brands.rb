FactoryGirl.define do
  factory :brand do
    sequence(:name){ |n| "My Brand #{ n }" }
display false
  end

end
