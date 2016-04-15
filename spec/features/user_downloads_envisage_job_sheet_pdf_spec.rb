require "rails_helper"

describe "User downloads envisage job sheet PDF" do
  scenario "finalised project" do
    user = create(:user)
    project = create(:finalised_project)
    print_job = create(:finalised_print_job, project: project, name: "Print job", description: "Description")
    design = create(:design, print_job: print_job)
    job_specification = create(:job_specification, print_job: print_job)
    product_item = create(:product_item, print_job: print_job)
    sundry_item = create(:sundry_item, print_job: print_job)
    supporting_product_item = create(:supporting_product_item, print_job: print_job)

    visit project_path(project, as: user)
    click_on "Download Envisage Job Sheet"

    expect(content_type).to eq("application/pdf")
    expect(content_disposition).to include("inline")
    expect(download_filename).to include(project.id.to_s)
    expect(pdf_body).to have_content("Job Sheet")
    expect(pdf_body).to have_content("Print job")
    expect(pdf_body).to have_content("Description")
    expect(pdf_body).to have_content(product_item.name)
    expect(pdf_body).to have_content(supporting_product_item.name)
    expect(pdf_body).to have_content(sundry_item.name)
    expect(pdf_body).to have_content(design.hours)
    expect(pdf_body).to have_content(job_specification.hours)
  end
end
