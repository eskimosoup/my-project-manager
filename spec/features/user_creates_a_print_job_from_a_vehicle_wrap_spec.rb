require "rails_helper"

feature "User creates a print job from a vehicle wrap", type: :feature do
  scenario "successfully adds a print job based on the vehicle wrap" do
    user = create(:user)
    brand = create(:my_vehicle_wrap_brand)
    project = create(:quoted_project, brand: brand)
    vehicle_type = create(:vehicle_type, name: "Large Van")
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type, name: "Full Wrap", description: "A full wrap on a large van",
                         envisage_override_price: 50, envisage_trade_override_price: 100, envisage_to_my_override_price: 150, my_override_price: 200)

    visit project_path(project, as: user)
    click_link "Add Vehicle Wrap"
    within "#vehicle_wrap_#{ vehicle_wrap.id }" do
      click_on "Add To Project"
    end

    expect(page).to have_css ".print-job-name", text: "Large Van - Full Wrap"
    expect(page).to have_css ".project-menu-brand-prices-breakdown li", text: "200"
  end
end
