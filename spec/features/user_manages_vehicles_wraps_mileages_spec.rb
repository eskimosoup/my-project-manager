require "rails_helper"

feature "User manages vehicles wraps mileages", type: :feature do
  scenario "successfully creates vehicle wraps mileage" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Mileage"

    fill_in "vehicle_wraps_mileage_miles", with: 4
    click_button "Create Mileage"

    expect(page).to have_css ".vehicle-wraps-mileage-details", text: "4.0 miles"
  end

  scenario "successfully edits vehicle wraps mileage" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
  end

  scenario "successfully removes vehicle wraps mileage" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
  end
end
