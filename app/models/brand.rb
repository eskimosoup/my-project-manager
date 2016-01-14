class Brand < ActiveRecord::Base

  has_one :brand_address
  has_one :address, through: :brand_address

  enum brand_type: [:my_office_branding, :envisage, :envisage_trade, :my_vehicle_wrap]
  validates :name, presence: true
  validates :brand_type, presence: true

  def logo
    case brand_type
    when "envisage", "envisage_trade"
      "logos/envisage.png"
    when "my_office_branding"
      "logos/my-office-branding.jpg"
    when "my_vehicle_wrap"
      "logos/my-vehicle-wrap.jpg"
    end
  end
end
