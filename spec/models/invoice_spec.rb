require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "associations", :association do
    it { should belong_to(:project) }
    it { should have_one(:customer).through(:project) }
    it { should have_one(:brand).through(:project) }
    it { should have_one(:business_address).through(:project) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }
  it { should delegate_method(:name).to(:project).with_prefix }
  it { should delegate_method(:prefix).to(:brand).with_prefix }
  it { should delegate_method(:single_line).to(:business_address).with_prefix }
  it { should delegate_method(:logo).to(:brand) }
  it { should delegate_method(:telephone).to(:brand) }
  it { should delegate_method(:email).to(:brand) }
  it { should delegate_method(:website).to(:brand) }

  it "#total_inc_vat" do
    invoice = build(:percentage_invoice)

    expect(invoice.total_inc_vat).to eq(invoice.amount + invoice.vat)
  end

  it "#number" do
    invoice = build_stubbed(:percentage_invoice)
    allow(invoice).to receive(:brand_prefix).and_return("MY")

    invoice_number = "MY#{ invoice.id + 500 }"

    expect(invoice.number).to eq(invoice_number)
  end
end
