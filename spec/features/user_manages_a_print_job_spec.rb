require "rails_helper"

describe "User manages a print job", type: :feature do
  scenario "add a print job" do
    user = create(:user)
    project = create(:project)

    visit project_path(project, as: user)

    click_on "Add"

    fill_form(:print_job, { name: "My print job", description: "my description" })
    click_on "Create Print job"

    expect(page).to have_css "h1", text: "My print job"
    expect(page).to have_css "p", text: "my description"
  end

  scenario "edit print job" do
    user = create(:user)
    project = create(:project)
    print_job = create(:print_job, project: project, name: "old name")

    visit print_job_path(print_job, as: user)
    click_link_by_href(edit_print_job_path(print_job))

    fill_form(:print_job, { name: "New print job name" })
    click_on "Update Print job"

    expect(page).to have_css "h1", text: "New print job name"
  end

  scenario "remove print job" do
    user = create(:user)
    project = create(:project)
    print_job = create(:print_job, project: project, name: "Blah")

    visit project_path(print_job.project, as: user)
    destroy_print_job(print_job)

    expect(page).not_to have_css ".print-job", text: "Blah"
  end

  def destroy_print_job(print_job)
    within "#print_job_#{ print_job.id }" do
      click_on "Remove"
    end
  end
end
