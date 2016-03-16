require "rails_helper"

feature "User manages vehicle wrap labour", type: :feature do
  scenario "successfully creates a vehicle wrap labour" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    labour = create(:labour)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Labour"

    fill_in "vehicle_wraps_labour_hours", with: 5.0
    select labour.name, from: "vehicle_wraps_labour_labour_id"
    click_button "Create Labour"

    expect(page).to have_css ".vehicle-wraps-labour-details", text: "5.0 hours"
    expect(page).to have_css ".vehicle-wraps-labour-details", text: labour.name
  end

  scenario "successfully edits a vehicle wrap labour" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    labour = create(:labour)
    vehicle_wrap_labour = create(:vehicle_wraps_labour, hours: 1.0, vehicle_wrap: vehicle_wrap, labour: labour)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_labour_path(vehicle_wrap_labour)

    fill_in "vehicle_wraps_labour_hours", with: 5.0
    select labour.name, from: "vehicle_wraps_labour_labour_id"
    click_button "Update Labour"

    expect(page).to have_css ".vehicle-wraps-labour-details", text: "5.0 hours"
    expect(page).to have_css ".vehicle-wraps-labour-details", text: labour.name
  end

  scenario "successfully removes a vehicle wrap labour" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    labour = create(:labour)
    vehicle_wrap_labour = create(:vehicle_wraps_labour, hours: 1.0, vehicle_wrap: vehicle_wrap, labour: labour)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_button "Remove"

    expect(page).not_to have_css ".vehicle-wraps-labour-details", text: "1.0 hours"
    expect(page).not_to have_css ".vehicle-wraps-labour-details", text: labour.name

  end
end
