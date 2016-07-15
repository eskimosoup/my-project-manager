require "rails_helper"

feature "user views my invoices" do
  scenario "all invoices" do
    user = create(:user)
    project = create(:project)
    invoice = create(:invoice, project: project, name: "My invoice") 

    visit root_path(as: user)
    click_link "My Invoices"

    expect(page).to have_css ".invoice .name", text: "My invoice"
  end

  scenario "unpaid invoices" do
    user = create(:user)
    project = create(:project)
    paid_invoice = create(:invoice, paid: true, project: project, name: "Paid invoice") 
    unpaid_invoice = create(:invoice, paid: false, project: project, name: "Unpaid invoice") 

    visit root_path(as: user)
    click_link "My Invoices"
    click_link "Paid"

    expect(page).to have_css ".invoice .name", text: "Paid invoice"
    expect(page).not_to have_css ".invoice .name", text: "Unpaid invoice"
  end

  scenario "paid invoices" do
    user = create(:user)
    project = create(:project)
    paid_invoice = create(:invoice, paid: true, project: project, name: "Invoice A") 
    unpaid_invoice = create(:invoice, paid: false, project: project, name: "Invoice B") 

    visit root_path(as: user)
    click_link "My Invoices"
    click_link "Paid"

    expect(page).not_to have_css ".invoice .name", text: "Invoice B"
    expect(page).to have_css ".invoice .name", text: "Invoice A"
  end
end
