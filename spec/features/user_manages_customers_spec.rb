require "rails_helper"

feature "User manages customers", type: :feature do
  scenario "creates customer with main contact" do
    user = create(:user)
    visit new_customer_registration_path(as: user)

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

  scenario "editing customer" do
    user = create(:user)
    customer = create(:customer, name: "Joe Bloggs", credit_limit: 500)

    visit customer_path(customer, as: user)
    within "h1" do
      click_link "Edit"
    end
    fill_form(:customer, { name: "Jane Bloggs" })
    click_on "Update Customer"
    
    expect(page).to have_css "h1", text: "Jane Bloggs"
    expect(current_path).to eq(customer_path(customer))
  end

  scenario "viewing customers" do
    user = create(:user)
    customer = create(:customer)

    visit customers_path(as: user)

    within "#customer_#{ customer.id }" do
      expect(page).to have_content(customer.name)
    end
  end

end
