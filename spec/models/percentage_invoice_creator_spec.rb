require "rails_helper"

describe PercentageInvoiceCreator, type: :model do
  it { should validate_presence_of(:percentage) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:percentage).is_greater_than(0).only_integer }
  it "validates project presence" do
    ic = PercentageInvoiceCreator.new

    ic.valid?

    expect(ic.errors.full_messages).to include("Project can't be blank")
  end

  context "percentage amount" do
    it "#amount" do
      ic = PercentageInvoiceCreator.new(percentage: 50, project_id: 1)
      allow(ic).to receive(:brand_price).and_return(100)

      expect(ic.amount).to eq(50)
    end
  end
end
