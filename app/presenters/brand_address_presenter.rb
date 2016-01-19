class BrandAddressPresenter < BasePresenter
  presents :brand_address
  delegate :line_1, :line_2, :line_3, :city, :postcode, to: :brand_address
end
