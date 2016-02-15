require "rails_helper"

describe "User downloads my job sheet PDF" do
  scenario "finalised project" do
    user = create(:user)
    project = create(:finalised_project)
    print_job = create(:finalised_print_job, project: project)

    visit project_path(project, as: user)
    click_on "Download My Job Sheet"
    expect(content_type).to eq("application/pdf")
    expect(content_disposition).to include("inline")
    expect(download_filename).to include(project.id.to_s)
    expect(pdf_body).to have_content("Job Sheet")
    expect(pdf_body).to have_content(print_job.name)
    expect(pdf_body).to have_content(print_job.envisage_to_my_price)
    expect(pdf_body).to have_content(print_job.brand_price)
  end
end
