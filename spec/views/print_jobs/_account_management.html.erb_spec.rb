require "rails_helper"

describe "print_jobs/_account_management.html.erb" do
  context "quoted print job" do
    it "shows add account management link" do
      print_job = quoted_print_job
      allow(print_job).to receive(:account_managements).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Account Management")
    end
  end

  context "sold print job" do
    it "does not show add account management link" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:account_managements).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Account Management")
    end
  end

end
