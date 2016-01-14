class Address < ActiveRecord::Base

  has_many :brand_addresses
  has_many :brands, through: :brand_addresses

  validates :line_1, presence: true
  validates :city, presence: true
  validates :postcode, presence: true
end
