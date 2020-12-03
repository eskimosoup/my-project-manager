# == Schema Information
#
# Table name: contacts
#
#  id                   :integer          not null, primary key
#  email                :string
#  forename             :string           not null
#  made_main_contact_at :datetime
#  phone                :string
#  role                 :string
#  surname              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  customer_id          :integer          not null
#
# Indexes
#
#  index_contacts_on_customer_id           (customer_id)
#  index_contacts_on_made_main_contact_at  (made_main_contact_at)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id) ON DELETE => cascade
#
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
