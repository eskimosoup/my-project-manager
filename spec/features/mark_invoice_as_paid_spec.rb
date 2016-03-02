require "rails_helper"

feature "marking an invoice as paid", type: :feature do
  it "successfully" do
    user = create(:user)
    project = create(:finalised_project)
    print_job = create(:finalised_print_job, project: project)
    invoice = create(:invoice, project: project, amount: project.brand_price, percentage: 100, name: "invoice")
    
    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Invoices"
    click_on "Mark As Paid"

    expect(page).to have_css ".invoice.paid"
  end
end
