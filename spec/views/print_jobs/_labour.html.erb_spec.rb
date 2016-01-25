require "rails_helper"

describe "print_jobs/_labour.html.erb" do
  context "quoted print job" do
    it "shows add labour item link" do
      print_job = quoted_print_job
      allow(print_job).to receive(:labour_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Labour")
    end
  end

  context "sold print job" do
    it "does not show add labour item link" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:labour_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Labour")
    end
  end

end
