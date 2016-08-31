require 'rails_helper'

RSpec.describe InvoiceSearch, type: :model do
  it 'searching paid invoices' do
    project = create(:project)
    invoice1 = create(:invoice, project: project, paid: true)
    invoice2 = create(:invoice, project: project, paid: false)

    search = InvoiceSearch.new(paid: true)

    expect(search.results).to include(invoice1)
    expect(search.results).not_to include(invoice2)
  end

  it 'searching unpaid invoices' do
    project = create(:project)
    invoice1 = create(:invoice, project: project, paid: false)
    invoice2 = create(:invoice, project: project, paid: true)

    search = InvoiceSearch.new(paid: false)

    expect(search.results).to include(invoice1)
    expect(search.results).not_to include(invoice2)
  end

  it 'returns all invoices if paid is set to nil' do
    project = create(:project)
    invoice1 = create(:invoice, project: project, paid: false)
    invoice2 = create(:invoice, project: project, paid: true)

    search = InvoiceSearch.new(paid: nil)

    expect(search.results).to include(invoice1)
    expect(search.results).to include(invoice2)
  end

  it 'search by customer' do
    customer = create(:customer)
    project = create(:project, customer: customer)
    invoice = create(:invoice, project: project)
    customer2 = create(:customer)
    project2 = create(:project, customer: customer2)
    invoice2 = create(:invoice, project: project2)

    search = InvoiceSearch.new(customer_id: customer.id)

    expect(search.results).to include(invoice)
    expect(search.results).not_to include(invoice2)
  end
end
