FactoryGirl.define do
  factory :contact do
    customer
    forename 'MyString'
    surname 'MyString'
    email 'MyString'
    phone 'MyString'
    role 'MyString'
    made_main_contact_at nil
  end
end
