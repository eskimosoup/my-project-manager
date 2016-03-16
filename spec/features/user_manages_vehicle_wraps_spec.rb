require "rails_helper"

feature "User manages a vehicle wrap", type: :feature do
  scenario "successfully creates a vehicle wrap" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)

    visit root_path(as: user)

    click_on "Preset Vehicle Wraps"
    click_on "New Vehicle Wrap"
    fill_form(:vehicle_wrap, { name: "Vehicle Wrap 1", description: "A complete vehicle wrap", vehicle_type: vehicle_type.name })

    click_on "Create Vehicle wrap"

    expect(page).to have_css ".vehicle-wrap-name", text: "Vehicle Wrap 1"
    expect(page).to have_css "#vehicle-wrap-description", text: "A complete vehicle wrap"
    expect(page).to have_css ".vehicle-wrap-vehicle-type", text: vehicle_type.name
  end

  scenario "successfully edits a vehicle wrap" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Edit"
    fill_form(:vehicle_wrap, { name: "Vehicle Wrap X", description: "A complete vehicle wrap for x", vehicle_type: vehicle_type.name })

    click_on "Update Vehicle wrap"

    expect(page).to have_css ".vehicle-wrap-name", text: "Vehicle Wrap X"
    expect(page).to have_css "#vehicle-wrap-description", text: "A complete vehicle wrap for x"
  end

end
