require "rails_helper"

feature "Managing envisage invoices", type: :feature do
  scenario "user creates an envisage invoice" do
    user = create(:user)
    brand = create(:my_office_branding_brand)
    project = create(:finalised_project, name: "Test", brand: brand)
    print_job = create(:finalised_print_job, project: project, vat: false, envisage_to_my_sale_price: 100.00)
    print_job = create(:finalised_print_job, project: project, vat: true, envisage_to_my_sale_price: 100.00)
    
    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_button "Create Envisage Invoice"

    expect(page).to have_css ".envisage-invoice .name", text: "Test"
    expect(page).to have_css ".envisage-invoice .percentage", text: "100%"
    expect(page).to have_css ".envisage-invoice .amount", text: "£200.00"
    expect(page).to have_css ".envisage-invoice .vat", text: "£20.00"
    expect(page).to have_css ".envisage-invoice .total", text: "220.00"
  end
end
