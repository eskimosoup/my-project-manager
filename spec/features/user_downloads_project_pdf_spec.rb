require "rails_helper"

describe "User downloads PDF" do
  scenario "for a quoted project" do
    user = create(:user)
    project = create(:quoted_project)
    print_job = create(:print_job, project: project)

    visit project_path(project, as: user)
    click_on "Download Quote"

    expect(content_type).to eq("application/pdf")
    expect(content_disposition).to include("inline")
    expect(download_filename).to include((project.id + 100).to_s)
    expect(pdf_body).to have_content(print_job.name)
    expect(pdf_body).to have_content(user.full_name)
  end
end
