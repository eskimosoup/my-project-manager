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
require 'rails_helper'

RSpec.describe BrandAddress, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:postcode) }
  end

  describe "associations", :association do
    it { should belong_to(:brand) }
  end
end
