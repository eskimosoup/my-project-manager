require "rails_helper"

feature "Admin creates a vehicle type", type: :feature do
  scenario "successfully" do
    user = create(:admin_user)

    visit admin_root_path(as: user)

    click_on "Vehicle Types"
    click_on "New vehicle type"

    fill_form(:vehicle_type, { name: "Large Van" })

    click_on "Create Vehicle type"

    expect(page).to have_css ".attribute-data.attribute-data--string", text: "Large Van"
  end
end
