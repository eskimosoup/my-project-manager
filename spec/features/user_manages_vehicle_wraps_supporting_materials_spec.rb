require "rails_helper"

feature "User manages vehicle wrap supporting materials", type: :feature do
  scenario "successfully creates a vehicle wrap supporting material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    supporting_product = create(:supporting_product)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Supporting Material"

    fill_in "vehicle_wraps_supporting_material_area", with: 5.0
    select supporting_product.name, from: "vehicle_wraps_supporting_material_supporting_product_id"
    click_button "Create Supporting material"

    expect(page).to have_css ".vehicle-wraps-supporting-material-details", text: "5.0m"
    expect(page).to have_css ".vehicle-wraps-supporting-material-details", text: supporting_product.name
  end
  
  scenario "successfully edits a vehicle wrap supporting material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    supporting_product = create(:supporting_product)
    vehicle_wrap_supporting_material = create(:vehicle_wraps_supporting_material, supporting_product: supporting_product, vehicle_wrap: vehicle_wrap, area: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_supporting_material_path(vehicle_wrap_supporting_material)

    fill_in "vehicle_wraps_supporting_material_area", with: 5.0
    select supporting_product.name, from: "vehicle_wraps_supporting_material_supporting_product_id"
    click_button "Update Supporting material"

    expect(page).to have_css ".vehicle-wraps-supporting-material-details", text: "5.0m"
    expect(page).to have_css ".vehicle-wraps-supporting-material-details", text: supporting_product.name
  end

  scenario "successfully remove a vehicle wrap supporting material" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    supporting_product = create(:supporting_product)
    vehicle_wrap_supporting_material = create(:vehicle_wraps_supporting_material, supporting_product: supporting_product, vehicle_wrap: vehicle_wrap, area: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_button "Remove"

    expect(page).not_to have_css ".vehicle-wraps-supporting-material-deatils", text: "5.0m"
    expect(page).not_to have_css ".vehicle-wraps-supporting-material-deatils", text: supporting_product.name
  end

end
