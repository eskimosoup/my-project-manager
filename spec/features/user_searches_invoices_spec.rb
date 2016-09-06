require 'rails_helper'

RSpec.feature 'user searches invoices' do
  scenario 'searching paid invoices' do
    user = create(:user)
    project = create(:project)
    paid_invoice = create(:percentage_invoice, paid: true, project: project, name: "Paid invoice")
    unpaid_invoice = create(:percentage_invoice, paid: false, project: project, name: "Unpaid invoice")

    visit root_path(as: user)
    click_link "My Invoices"
    select "Paid", from: "my_invoice_search_paid"
    click_button "Search"

    expect(page).to have_content paid_invoice.name
    expect(page).not_to have_content unpaid_invoice.name
  end

  scenario 'searching unpaid invoices' do
    user = create(:user)
    project = create(:project)
    paid_invoice = create(:percentage_invoice, paid: true, project: project, name: "Paid invoice")
    unpaid_invoice = create(:percentage_invoice, paid: false, project: project, name: "Unpaid invoice")

    visit root_path(as: user)
    click_link "My Invoices"
    select "Unpaid", from: "my_invoice_search_paid"
    click_button "Search"

    expect(page).to have_content unpaid_invoice.name
    expect(page).not_to have_content paid_invoice.name
  end
end
