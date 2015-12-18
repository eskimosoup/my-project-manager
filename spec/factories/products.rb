FactoryGirl.define do
  factory :product do
    name "MyString"
    description "MyText"
    substrate_cost 9.99
    hardware_cost 9.99
    ink_cost 9.99
    printer_cost 9.99
    mark_up 300 
  end

end
