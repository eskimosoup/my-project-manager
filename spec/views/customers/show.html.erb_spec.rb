require "rails_helper"

describe "customers/show.html.erb" do
  context "customer has projects" do
    it "displays the projects info" do
      projects = [build_stubbed(:project)]
      assign(:customer, instance_double("Customer", name: "Blah", projects: projects, payment_days: 0, addresses: []))

      render

      expect(rendered).to have_content "Projects"
    end
  end

  context "customer has no projects" do
    it "doesn't display projects info" do
      assign(:customer, instance_double("Customer", name: "Blah", payment_days: 0, projects: [], addresses: []))

      render

      expect(rendered).to_not have_content "Projects"
    end
  end
end
