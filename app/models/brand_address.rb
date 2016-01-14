class BrandAddress < ActiveRecord::Base
  belongs_to :brand
  belongs_to :address
end
