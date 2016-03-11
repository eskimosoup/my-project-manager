require "rails_helper"

describe "print_jobs/_supporting_products.html.erb" do
  context "quoted print job" do
    it "shows supporting product links" do
      print_job = quoted_print_job
      allow(print_job).to receive(:supporting_product_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).to have_content("Add Supporting Material")
    end
  end

  context "sold print job" do
    it "does not show add supporting product link" do
      print_job = not_quoted_print_job
      allow(print_job).to receive(:supporting_product_items).and_return([])
      assign(:print_job, print_job)

      render

      expect(rendered).not_to have_content("Add Supporting Material")
    end
  end
end
