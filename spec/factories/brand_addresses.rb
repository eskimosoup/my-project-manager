# == Schema Information
#
# Table name: brand_addresses
#
#  id         :integer          not null, primary key
#  city       :string           not null
#  line_1     :string           not null
#  line_2     :string
#  line_3     :string
#  name       :string
#  postcode   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :integer
#
# Indexes
#
#  index_brand_addresses_on_brand_id  (brand_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :brand_address do
    brand
    name "name"
    line_1 "MyString"
    line_2 "MyString"
    city "MyString"
    postcode "MyString"
  end

end
