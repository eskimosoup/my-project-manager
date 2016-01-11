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

end
