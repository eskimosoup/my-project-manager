class Brand < ActiveRecord::Base
  MY_BRANDS = %w( my_office_branding my_vehicle_wrap ).freeze 

  has_one :brand_address

  enum brand_type: [:my_office_branding, :envisage, :envisage_trade, :my_vehicle_wrap]
  validates :name, presence: true
  validates :email, presence: true
  validates :brand_type, presence: true
  validates :account_management_rate, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  delegate :logo, :colour, to: :brand_graphics
  
  def brand_graphics
    @brand_graphics ||= BrandGraphics.klass_for(brand_type).new
  end

  def my_brand?
    MY_BRANDS.include?(brand_type)
  end

  def prefix
    if my_brand?
      "MY"
    else
      "EN"
    end
  end
end
