require "rails_helper"

feature "User creates a customer do", type: :feature do
  scenario "successfully" do
    user = create(:user)
    visit new_customer_registration_path

    fill_form(:customer_registration, { customer_name: "Customer name", customer_credit_limit: 500.00,
                                        contact_name: "Joe Bloggs", contact_email: "joe.bloggs@example.com", 
                                        contact_phone: "01482 999 999", contact_role: "Sales" })

    click_on "Create Customer"

    expect(page).to have_css "h1", text: "Customer name"
  end
end
