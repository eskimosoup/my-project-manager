require "rails_helper"

feature "customer pays an invoice", type: :feature do
  scenario "allows payment when invoice is unpaid", js: true, skip: true do
    project = create(:finalised_project)
    invoice = create(:percentage_invoice, project: project, paid: false)

    visit customer_invoice_path(invoice)
    click_on "Pay Invoice"
    fill_in_card_number
    date = Date.today + 1.year
    fill_in_card_expiry(month:  date.month, year: date.year)
    fill_in_card_cvc
    click_button "Submit Payment"

    expect(page).to have_css "#paid-notice", text: "This invoice has been paid"
    expect(current_path).to eq(customer_invoice_path(invoice))
  end

  scenario "does not allow payment when an invoice is paid" do
    project = create(:finalised_project)
    invoice = create(:percentage_invoice, project: project, paid: true)

    visit customer_invoice_path(invoice)

    expect(page).to have_css "#paid-notice", text: "This invoice has been paid"
  end
end
