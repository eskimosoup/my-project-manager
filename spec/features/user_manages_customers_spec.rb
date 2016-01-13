require "rails_helper"

feature "User manages customers", type: :feature do
  scenario "creates customer" do
    user = create(:user)
    visit new_customer_registration_path

    fill_form(:customer_registration, { customer_name: "Customer name", 
                                        customer_credit_limit: 500.00,
                                        contact_name: "Joe Bloggs", 
                                        contact_email: "joe.bloggs@example.com", 
                                        contact_phone: "01482 999 999", 
                                        contact_role: "Sales"
    })

    click_on "Create Customer"

    expect(page).to have_css "h1", text: "Customer name"
  end

  scenario "viewing customers" do
    customer = create(:customer)

    visit customers_path

    within "#customer_#{ customer.id }" do
      expect(page).to have_content(customer.name)
    end
  end

end
