require "rails_helper"

feature "User manages vehicle wrap materials", type: :feature do
  scenario "successfully creates a vehicle wrap material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    product = create(:product)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Material"

    fill_in "vehicle_wraps_material_area", with: 5.0
    select product.name, from: "vehicle_wraps_material_product_id"
    click_button "Create Material"

    expect(page).to have_css ".vehicle-wraps-material-details", text: "5.0m"
    expect(page).to have_css ".vehicle-wraps-material-details", text: product.name
  end

  scenario "successfully edits a vehicle wrap material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    product = create(:product)
    vehicle_wrap_material = create(:vehicle_wraps_material, product: product, vehicle_wrap: vehicle_wrap, area: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_material_path(vehicle_wrap_material)

    fill_in "vehicle_wraps_material_area", with: 10.0
    click_button "Update Material"

    expect(page).to have_css ".vehicle-wraps-material-details", text: "10.0m"
  end

  scenario "successfully remove a vehicle wrap material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    product = create(:product)
    vehicle_wrap_material = create(:vehicle_wraps_material, product: product, vehicle_wrap: vehicle_wrap, area: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_button "Remove"

    expect(page).not_to have_css ".vehicle-wraps-material-deatils", text: "5.0m"
    expect(page).not_to have_css ".vehicle-wraps-material-deatils", text: product.name
  end
end
