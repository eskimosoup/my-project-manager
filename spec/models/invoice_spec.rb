# == Schema Information
#
# Table name: invoices
#
#  id                        :integer          not null, primary key
#  amount                    :decimal(10, 2)   not null
#  due_date                  :date             not null
#  name                      :string           not null
#  non_vat_items_description :text
#  non_vat_items_total       :decimal(10, 2)
#  paid                      :boolean          default(FALSE), not null
#  percentage                :integer
#  slug                      :string
#  type                      :string           default("PercentageInvoice")
#  vat                       :decimal(10, 2)   default(0.0)
#  vat_items_description     :text
#  vat_items_total           :decimal(10, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_id                :integer          not null
#  stripe_charge_id          :string
#
# Indexes
#
#  index_invoices_on_project_id        (project_id)
#  index_invoices_on_slug              (slug) UNIQUE
#  index_invoices_on_stripe_charge_id  (stripe_charge_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
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
