require "rails_helper"

feature "managing project invoices", type: :feature do
  scenario "user creates a percentage invoice" do
    user = create(:user)
    brand = create(:my_office_branding_brand)
    customer = create(:customer, payment_days: 5)
    address = create(:address, customer: customer)
    project = create(:finalised_project, brand: brand, customer: customer, billing_address: address)
    print_job = create(:finalised_print_job, project: project, vat: false, my_sale_price: 100.00)
    print_job = create(:finalised_print_job, project: project, vat: true, my_sale_price: 100.00)

    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Invoices"
    click_on "Add Percentage Invoice"

    fill_in "percentage_invoice_creator_percentage", with: 50
    fill_in "percentage_invoice_creator_name", with: "Name"
    fill_in "percentage_invoice_creator_days_to_pay", with: 30
    click_on "Create Invoice"

    expect(page).to have_css ".invoice", text: "Name"
    expect(page).to have_css ".due-date", text: I18n.l((Date.today + 30))
    expect(page).to have_css ".percentage", text: "50%"
    expect(page).to have_css ".amount", text: "£100.00"
    expect(page).to have_css ".vat", text: "£10.00"
    expect(page).to have_css ".total", text: "110.00"
  end

  scenario "user attempts to create invoice on project without billing address" do
    user = create(:user)
    brand = create(:my_office_branding_brand)
    customer = create(:customer, payment_days: 5)
    project = create(:finalised_project, brand: brand, customer: customer, billing_address: nil)
    print_job = create(:finalised_print_job, project: project, vat: false, my_sale_price: 100.00)
    print_job = create(:finalised_print_job, project: project, vat: true, my_sale_price: 100.00)

    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Invoices"
    click_on "Add Percentage Invoice"

    fill_in "percentage_invoice_creator_percentage", with: 50
    fill_in "percentage_invoice_creator_name", with: "Name"
    fill_in "percentage_invoice_creator_days_to_pay", with: 30
    click_on "Create Invoice"

    expect(page).to have_content "Project has no billing address"
  end
end
