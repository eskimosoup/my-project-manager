require 'rails_helper'

RSpec.describe AmountInvoiceCreator, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:days_to_pay).is_greater_than_or_equal_to(0).only_integer }
  it "validates project presence" do
    ic = AmountInvoiceCreator.new

    ic.valid?

    expect(ic.errors.full_messages).to include("Project can't be blank")
  end

  it 'validates vat item total numericality if vat description exists' do
    ic = AmountInvoiceCreator.new(vat_items_description: "blah")

    expect(ic).to validate_numericality_of(:vat_items_total).is_greater_than_or_equal_to(0)
  end

  it 'validates non vat item total numericality if non vat description exists' do
    ic = AmountInvoiceCreator.new(non_vat_items_description: "blah")

    expect(ic).to validate_numericality_of(:non_vat_items_total).is_greater_than_or_equal_to(0)
  end

  describe '#vat' do
    it 'has vat items total' do
      ic = AmountInvoiceCreator.new(vat_items_total: 100)

      expect(ic.vat).to eq(20)
    end

    it 'has vat items total' do
      ic = AmountInvoiceCreator.new

      expect(ic.vat).to eq(0)
    end
  end

  it '#amount' do
    ic = AmountInvoiceCreator.new(vat_items_total: 100, non_vat_items_total: 100)

    expect(ic.amount).to eq(200)
  end
end
