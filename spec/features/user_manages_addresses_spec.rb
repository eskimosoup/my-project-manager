require "rails_helper"

feature "User manages customer addresses" do
  scenario "Adding an address" do
    user = create(:user)
    customer = create(:customer)

    visit customer_path(customer, as: user)
    click_on "Add New Address"

    fill_form(:address, { name: "Address 1", line_1: "Somewhere", city: "Hull", postcode: "HU1 1NQ" })
    click_on "Create Address"

    expect(page).to have_content "Address 1"
  end

  scenario "Editing an address" do
    user = create(:user)
    customer = create(:customer)
    address = create(:address, customer: customer)

    visit customer_path(customer, as: user)
    click_link_by_href(edit_address_path(address))

    fill_in "Name", with: "New name"
    click_on "Update Address"

    expect(page).to have_content "New name"
  end

  scenario "Removing an address" do
    user = create(:user)
    customer = create(:customer)
    address = create(:address, customer: customer)

    visit customer_path(customer, as: user)
    click_on "Remove"

    expect(page).not_to have_content address.name
  end
end
