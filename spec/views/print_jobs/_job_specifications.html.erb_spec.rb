require "rails_helper"

describe "print_jobs/_job_specifications.html.erb" do
  context "quoted print job" do
    it "shows add job specification link" do
      print_job = quoted_print_job
      allow(print_job).to receive(:job_specifications).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Job Specification")
    end
  end

  context "sold print job" do
    it "does not show add job specification link" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:job_specifications).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Job Specification")
    end
  end

end
