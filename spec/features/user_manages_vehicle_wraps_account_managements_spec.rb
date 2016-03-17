require "rails_helper"

feature "User manages vehicle wraps account managements", type: :feature do
  scenario "successfully creates a vehicle wrap account management" do
    user = create(:user)
    brand = create(:my_vehicle_wrap_brand)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Add Account Management"

    fill_in "vehicle_wraps_account_management_hours", with: 5.0
    click_button "Create Account management"

    expect(page).to have_css ".vehicle-wraps-account-management-details", text: "5.0 hours"
  end

  scenario "successfully edits a vehicle wrap account management" do
    user = create(:user)
    brand = create(:my_vehicle_wrap_brand)
    vehicle_type = create(:vehicle_type)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_account_management = create(:vehicle_wraps_account_management, vehicle_wrap: vehicle_wrap, hours: 3.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_link_by_href edit_vehicle_wraps_account_management_path(vehicle_wrap_account_management)

    fill_in "vehicle_wraps_account_management_hours", with: 5.0
    click_button "Update Account management"

    expect(page).to have_css ".vehicle-wraps-account-management-details", text: "5.0 hours"
  end

  scenario "successfully removes a vehicle wrap account management" do
    user = create(:user)
    vehicle_type = create(:vehicle_type)
    brand = create(:my_vehicle_wrap_brand)
    vehicle_wrap = create(:vehicle_wrap, vehicle_type: vehicle_type)
    vehicle_wrap_account_management = create(:vehicle_wraps_account_management, vehicle_wrap: vehicle_wrap, hours: 5.0)

    visit root_path(as: user)
    click_on "Preset Vehicle Wraps"
    click_link_by_href vehicle_wrap_path(vehicle_wrap)
    click_on "Remove"

    expect(page).not_to have_css ".vehicle-wraps-account-management-details", text: "5.0 hours"
  end

end
