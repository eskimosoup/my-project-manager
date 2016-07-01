require 'rails_helper'

RSpec.describe "projects/_envisage_invoices.html.erb", type: :view do
  context 'project has envisage invoices' do
    it 'renders the invoices' do
      envisage_invoice = build_stubbed(:envisage_invoice, name: "Envisage Invoice")
      project = build(:project, envisage_invoices: [envisage_invoice])

      render partial: "projects/envisage_invoices.html.erb",
        locals: { project: project }

      expect(rendered).to have_content envisage_invoice.name
    end
  end

  context "envisage to my price is not zero" do
    it 'renders the create invoice button' do
      project = build_stubbed(:project, envisage_invoices: [])
      allow(project).to receive(:envisage_to_my_price).and_return(5)

      render partial: "projects/envisage_invoices.html.erb",
        locals: { project: project }

      expect(rendered).to have_css ".action-button"
    end
  end

  context 'envisage to my price is zero' do
    it 'does not render the create invoice button' do
      project = build_stubbed(:project, envisage_invoices: [])
      allow(project).to receive(:envisage_to_my_price).and_return(0)

      render partial: "projects/envisage_invoices.html.erb",
        locals: { project: project }

      expect(rendered).not_to have_css ".action-button"
    end
  end
end
