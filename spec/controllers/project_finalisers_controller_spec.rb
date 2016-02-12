require "rails_helper"

describe ProjectFinalisersController, type: :controller do
  describe "#create" do
    it "failed" do
      project = create(:sold_project)
      print_job = create(:sold_print_job, project: project)
      attrs = {
        "print_job_#{ print_job.id }_envisage_sale_price" => print_job.envisage_sale_price,
        "print_job_#{ print_job.id }_envisage_trade_sale_price" => print_job.envisage_trade_sale_price,
        "print_job_#{ print_job.id }_envisage_to_my_sale_price" => print_job.envisage_to_my_sale_price,
        "print_job_#{ print_job.id }_my_sale_price" => 0,
      }

      sign_in
      post :create, { project_id: project.id, status_changer_finalised: attrs }

      expect(response).to render_template(:new)
    end
  end
end
