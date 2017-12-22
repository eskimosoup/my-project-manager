class BrandGraphics
  def logo
    raise NotImplementedError
  end

  def colour
    raise NotImplementedError
  end

  def self.klass_for(brand_type)
    case brand_type
    when 'envisage', 'envisage_trade'
      EnvisageBrandGraphics
    when 'my_office_branding'
      MyOfficeBrandGraphics
    when 'my_vehicle_wrap'
      MyVehicleWrapBrandGraphics
    when 'my_print_services'
      MyPrintServicesBrandGraphics
    when 'my_design'
      MyDesignBrandGraphics
    when 'my_internet_marketing'
      MyInternetMarketingBrandGraphics
    when 'my_team'
      MyTeamGraphics
    end
  end
end
