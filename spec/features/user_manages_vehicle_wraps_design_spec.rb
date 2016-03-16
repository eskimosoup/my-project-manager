require "rails_helper"

feature "User manages vehicle wraps designs", type: :feature do
  scenario "successfully creates a vehicle wrap design" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Design"

    fill_in "vehicle_wraps_design_hours", with: 5.0
    click_button "Create Design"

    expect(page).to have_css ".vehicle-wraps-design-details", text: "5.0 hours"
  end

  scenario "successfully edits a vehicle wrap design" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_design = create(:vehicle_wraps_design, vehicle_wrap: vehicle_wrap, hours: 3.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_design_path(vehicle_wrap_design)

    fill_in "vehicle_wraps_design_hours", with: 5.0
    click_button "Update Design"

    expect(page).to have_css ".vehicle-wraps-design-details", text: "5.0 hours"
  end

  scenario "successfully removes a vehicle wrap design" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_design = create(:vehicle_wraps_design, vehicle_wrap: vehicle_wrap, hours: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Remove"

    expect(page).not_to have_css ".vehicle-wraps-design-details", text: "5.0 hours"
  end

end
