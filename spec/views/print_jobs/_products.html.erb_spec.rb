require "rails_helper"

describe "print_jobs/_products.html.erb" do
  context "quoted print job" do
    it "shows product links" do
      print_job = quoted_print_job
      allow(print_job).to receive(:product_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Product")
      expect(rendered).to have_content("Add Multiple Products")
    end
  end

  context "sold print job" do
    it "does not show add product links" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:product_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Product")
      expect(rendered).not_to have_content("Add Multiple Products")
    end
  end

end
