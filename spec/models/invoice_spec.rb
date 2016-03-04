require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "associations", :association do
    it { should belong_to(:project) }
    it { should have_one(:customer).through(:project) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }
  it { should delegate_method(:name).to(:project).with_prefix }

  it "#vat" do
    invoice = build(:invoice)

    expect(invoice.vat).to eq(invoice.amount * 0.2)
  end

  it "#total_inc_vat" do
    invoice = build(:invoice)

    expect(invoice.total_inc_vat).to eq(invoice.amount * 1.2)
  end
end
