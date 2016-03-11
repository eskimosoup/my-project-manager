require "rails_helper"

feature "User manages projects" do
  scenario "creating a project" do
    user = create(:user)
    customer = create(:customer)
    brand = create(:brand)

    visit new_project_path(as: user)

    fill_form(:project, { name: "My project name", brand_id: brand.name, rush_job: true,
                          customer_id: customer.name, description: "Project description",
                          delivery_deadline: 2.weeks.from_now, notes: "Some notes" })
    click_on "Create Project"

    expect(page).to have_css "h1", text: "My project name"
    expect(page).to have_css "#delivery-deadline", text: I18n.l(2.weeks.from_now.to_date)
    expect(page).to have_css "#notes", text: "Some notes"
  end

  scenario "editing a project" do
    user = create(:user)
    customer = create(:customer)
    brand = create(:brand)
    project = create(:project, brand: brand, customer: customer)

    visit project_path(project, as: user)
    within "h1" do
      click_on "Edit"
    end
    fill_form(:project, { name: "My new project name", brand_id: brand.name, rush_job: true,
                          customer_id: customer.name, description: "Project description",
                          delivery_deadline: 2.weeks.from_now, notes: "Some notes" })
    click_on "Update Project"

    expect(page).to have_css "h1", text: "My new project name"
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
    expect(page).to have_link("Add", href: new_project_print_job_path(project))
  end
end
