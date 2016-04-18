require "rails_helper"

feature "managing contacts" do
  it "#creation" do # also created when creating a customer
    user = create(:user)
    customer = create(:customer)

    visit customer_path(customer, as: user)
    click_link "Contacts"
    click_link "New Contact"

    fill_form(:contact, { forename: "Joe", surname: "Bloggs",
    email: "email@example.com", role: "Some role" })
    click_button "Create Contact"

    expect(page).to have_content "Joe"
  end

  it "editing" do
    user = create(:user)
    customer = create(:customer)
    contact = create(:contact, forename: "Joe", customer: customer)

    visit customer_path(customer, as: user)
    click_link "Contacts"
    click_link_by_href(edit_contact_path(contact))
    fill_form(:contact, { forename: "Joseph" })
    click_button "Update Contact"

    expect(page).to have_content "Joseph"
  end
end
