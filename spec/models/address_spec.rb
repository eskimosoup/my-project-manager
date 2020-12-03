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
require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:postcode) }
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
  end
end
