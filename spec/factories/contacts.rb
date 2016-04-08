FactoryGirl.define do
  factory :contact do
    customer
    forename 'MyString'
    surname 'MyString'
    email 'MyString'
    phone 'MyString'
    role 'MyString'
  end
end
