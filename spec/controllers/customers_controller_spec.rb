require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe "GET index" do
    it "assigns @customers" do
      customer = create(:customer)
      get :index
      expect(assigns(:customers)).to include(customer)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it "responds with success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "assigns @customer" do
      customer = create(:customer)
      get :show, id: customer.id
      expect(assigns(:customer)).to eq(customer)
    end

    it "renders the :show view" do
      customer = create(:customer)
      get :show, id: customer.id

      expect(response).to render_template :show
    end

    it "responds with success" do
      customer = create(:customer)
      get :show, id: customer.id

      expect(response).to have_http_status(:success)
    end
  end
end
