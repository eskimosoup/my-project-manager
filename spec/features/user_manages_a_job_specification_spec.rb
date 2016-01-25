require "rails_helper"

describe "User manages a print job's job specifications", type: :feature do
  scenario "adds job specification" do
    user = create(:user)
    print_job = create(:print_job)

    visit print_job_path(print_job, as: user)
    click_on "Add Job Specification"

    fill_form(:job_specification, { hours: 5 })
    click_on "Create Job specification"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".basic-listing-details", text: "5.0 hours"
  end

  scenario "edits a job specification" do
    user = create(:user)
    job_spec = create(:job_specification)

    visit print_job_path(job_spec.print_job, as: user)
    edit_job_specification(job_spec)

    fill_in "Hours", with: 8.0
    click_on "Update Job specification"

    expect(page).to have_css ".basic-listing-details", text: "8.0 hours"
  end

  scenario "removes job specification" do
    user = create(:user)
    job_spec = create(:job_specification)

    visit print_job_path(job_spec.print_job, as: user)
    destroy_job_specification(job_spec)

    expect(page).not_to have_css ".basic-listing-details", text: "#{ job_spec.hours } hours"
  end

  def edit_job_specification(job_spec)
    within "#job_specification_#{ job_spec.id }" do
      click_link_by_href edit_job_specification_path(job_spec)
    end
  end

  def destroy_job_specification(job_spec)
    within "#job_specification_#{ job_spec.id }" do
      click_on "Remove"
    end
  end
end
