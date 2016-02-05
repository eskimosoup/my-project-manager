class Brand < ActiveRecord::Base

  has_one :brand_address

  enum brand_type: [:my_office_branding, :envisage, :envisage_trade, :my_vehicle_wrap]
  validates :name, presence: true
  validates :brand_type, presence: true
  validates :account_management_rate, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  delegate :logo, :colour, to: :brand_graphics
  
  def brand_graphics
    @brand_graphics ||= BrandGraphics.klass_for(brand_type).new
  end
end
