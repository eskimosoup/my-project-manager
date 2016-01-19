require "rails_helper"

feature "User manages projects" do
  scenario "creating a project" do
    user = create(:user)
    customer = create(:customer)
    brand = create(:brand)

    visit new_project_path(as: user)

    fill_form(:project, { name: "My project name", brand_id: brand.name,
                          customer_id: customer.name, description: "Project description" })
    click_on "Create Project"

    expect(page).to have_css "h1", text: "My project name"
  end

  scenario "viewing projects #index" do
    user = create(:user)
    project = create(:project)

    visit projects_path(as: user)

    expect(page).to have_link("New Project", href: new_project_path)
    within "#project_#{ project.id }" do
      expect(page).to have_content(project.name)
    end
  end

  scenario "viewing projects #show" do
    user = create(:user)
    project = create(:project)
    print_job = create(:print_job, project: project)

    visit project_path(project, as: user)

    within "#print_job_#{ print_job.id }" do
      expect(page).to have_content(print_job.name)
    end
    expect(page).to have_link("Add Print Item", href: new_project_print_job_path(project))
  end
end
