class Brand < ActiveRecord::Base
  enum brand_type: [:my, :envisage]
  validates :name, presence: true
  validates :brand_type, presence: true
end
