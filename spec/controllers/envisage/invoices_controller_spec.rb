require 'rails_helper'

RSpec.describe Envisage::InvoicesController, type: :controller do
  describe "#index" do
    it "assigns @invoices" do
      project = create(:finalised_project)
      invoice = create(:envisage_invoice, project: project)

      sign_in

      get :index

      expect(assigns(:invoices)).to eq([invoice])
    end
  end
end
