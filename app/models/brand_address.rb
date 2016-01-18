class BrandAddress < ActiveRecord::Base
  belongs_to :brand
  validates :brand, presence: true
  validates :city, presence: true
  validates :line_1, presence: true
  validates :postcode, presence: true
end
