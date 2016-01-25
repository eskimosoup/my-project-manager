require "rails_helper"

describe "print_jobs/_sundry_items.html.erb" do
  context "quoted print job" do
    it "shows add sundry item link" do
      print_job = quoted_print_job
      allow(print_job).to receive(:sundry_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Sundry Item")
    end
  end

  context "sold print job" do
    it "does not show add sundry item link" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:sundry_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Sundry Item")
    end
  end

end
