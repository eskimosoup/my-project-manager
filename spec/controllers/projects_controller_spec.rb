require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "GET index" do
    it "assigns @projects" do
      sign_in
      project = create(:project)

      get :index
      expect(assigns(:projects)).to include(project)
    end

    it "renders the :index view" do
      sign_in

      get :index
      expect(response).to render_template :index
    end

    it "responds with success" do
      sign_in

      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
