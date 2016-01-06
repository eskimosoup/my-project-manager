require "rails_helper"

describe "User manages a print job", type: :feature do
  scenario "add a print job" do
    project = create(:project)

    visit project_path(project)

    click_on "Add Print Job"

    fill_form(:print_job, { name: "My print job" })
    click_on "Create Print job"

    expect(page).to have_css "h1", text: "My print job"
  end

  scenario "edit print job" do
    print_job = create(:print_job)

    visit print_job_path(print_job)
    click_on "Edit"

    fill_in "Name", with: "New print job name"
    click_on "Update Print job"

    expect(page).to have_css "h1", text: "New print job name"
  end

  scenario "remove print job" do
    print_job = create(:print_job)

    visit project_path(print_job.project)
    destroy_print_job(print_job)

    expect(page).not_to have_css ".print-job", text: print_job.name
  end

  def destroy_print_job(print_job)
    within "#print_job_#{ print_job.id }" do
      click_on "Remove"
    end
  end
end
