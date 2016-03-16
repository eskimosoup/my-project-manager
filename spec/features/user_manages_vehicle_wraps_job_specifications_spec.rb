require "rails_helper"

feature "User manages vehicle wraps job specifications", type: :feature do
  scenario "successfully creates a vehicle wrap job specification" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Job Specification"

    fill_in "vehicle_wraps_job_specification_hours", with: 5.0
    click_button "Create Job specification"

    expect(page).to have_css ".vehicle-wraps-job-specification-details", text: "5.0 hours"
  end

  scenario "successfully edits a vehicle wrap job specification" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_job_specification = create(:vehicle_wraps_job_specification, vehicle_wrap: vehicle_wrap, hours: 3.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_job_specification_path(vehicle_wrap_job_specification)

    fill_in "vehicle_wraps_job_specification_hours", with: 5.0
    click_button "Update Job specification"

    expect(page).to have_css ".vehicle-wraps-job-specification-details", text: "5.0 hours"
  end

  scenario "successfully removes a vehicle wrap job specification" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_job_specification = create(:vehicle_wraps_job_specification, vehicle_wrap: vehicle_wrap, hours: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Remove"

    expect(page).not_to have_css ".vehicle-wraps-job-specification-details", text: "5.0 hours"
  end
end
