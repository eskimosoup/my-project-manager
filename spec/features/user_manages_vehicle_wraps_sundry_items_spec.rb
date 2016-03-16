require "rails_helper"

feature "User manages vehicle wraps sundry items" do
  scenario "successfully creates a vehicle wrap sundry item" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Sundry Item"

    fill_in "vehicle_wraps_sundry_item_name", with: "Some name"
    fill_in "vehicle_wraps_sundry_item_cost", with: 5.50
    click_button "Create Sundry item"

    expect(page).to have_css ".vehicle-wraps-sundry-item-details", text: "5.50"
    expect(page).to have_css ".vehicle-wraps-sundry-item-details", text: "Some name"
  end

  scenario "successfully edits a vehicle wrap sundry item" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_sundry_item = create(:vehicle_wraps_sundry_item, name: "Blah", cost: 2.50, vehicle_wrap: vehicle_wrap)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_sundry_item_path(vehicle_wrap_sundry_item)

    fill_in "vehicle_wraps_sundry_item_name", with: "Some name"
    fill_in "vehicle_wraps_sundry_item_cost", with: 5.50
    click_button "Update Sundry item"

    expect(page).to have_css ".vehicle-wraps-sundry-item-details", text: "5.50"
    expect(page).to have_css ".vehicle-wraps-sundry-item-details", text: "Some name"
  end

  scenario "successfully removes a vehicle wrap sundry item" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_sundry_item = create(:vehicle_wraps_sundry_item, name: "Blah", cost: 2.50, vehicle_wrap: vehicle_wrap)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Remove"

    expect(page).not_to have_css ".vehicle-wraps-sundry-item-details", text: "5.50"
    expect(page).not_to have_css ".vehicle-wraps-sundry-item-details", text: "Some name"
  end



end
