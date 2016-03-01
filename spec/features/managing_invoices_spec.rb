require "rails_helper"

feature "managing project invoices", type: :feature do
  it "user creates an invoice" do
    user = create(:user)
    project = create(:finalised_project)
    print_job = create(:finalised_print_job, project: project)
    
    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Invoices"
    click_on "Add"

    fill_in "Percentage", with: 50
    click_on "Create Invoice"

    expect(page).to have_css ".percentage", text: "50%"
  end
end
