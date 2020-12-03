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
class BrandAddress < ActiveRecord::Base
  belongs_to :brand
  validates :brand, presence: true
  validates :city, presence: true
  validates :line_1, presence: true
  validates :postcode, presence: true

  def single_line
    [line_1, line_2, line_3, city, postcode].reject{|x| x.empty? }.compact.join(", ")
  end
end
