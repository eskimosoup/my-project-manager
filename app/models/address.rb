class Address < ActiveRecord::Base

  belongs_to :customer
  validates :customer, presence: true
  validates :city, presence: true
  validates :line_1, presence: true
  validates :postcode, presence: true
end
