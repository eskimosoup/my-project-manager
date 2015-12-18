require "rails_helper"

feature "User creates a project" do
  scenario "successfully" do
    user = create(:user)
    customer = create(:customer)

    visit new_project_path

    fill_form(:project, { name: "My project name", customer_id: customer.name, description: "Project description" })
    click_on "Create Project"

    expect(page).to have_css "h1", text: "My project name"
  end
end
