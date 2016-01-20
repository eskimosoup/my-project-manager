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
