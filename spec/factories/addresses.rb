# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  city        :string           not null
#  line_1      :string           not null
#  line_2      :string
#  line_3      :string
#  name        :string
#  postcode    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#
# Indexes
#
#  index_addresses_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :address do
    customer
    name "name"
    line_1 "MyString"
    line_2 "MyString"
    city "MyString"
    postcode "MyString"
  end

end
