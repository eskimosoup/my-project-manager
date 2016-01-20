require "rails_helper"

describe "User manages design", type: :feature do
  it "creates design" do
    user = create(:user)
    print_job = create(:print_job)

    visit print_job_path(print_job, as: user)
    click_on "Add Design"

    fill_form(:design, { hours: 5 })
    click_on "Create Design"

    expect(page).to have_css ".design", text: "5.0 hours"
  end

  it "edits design" do
    user = create(:user)
    design = create(:design)

    visit print_job_path(design.print_job, as: user)
    edit_design(design)

    fill_in "Hours", with: 3
    click_on "Update Design"

    expect(page).to have_css ".design", text: "3.0 hours"
  end

  it "removes design" do
    user = create(:user)
    design = create(:design)

    visit print_job_path(design.print_job, as: user)
    destroy_design(design)

    expect(page).not_to have_css "#design_#{ design.id }"
  end

  def edit_design(design)
    within("#design_#{ design.id }") do
      click_on "Edit"
    end
  end

  def destroy_design(design)
    within("#design_#{ design.id }") do
      click_on "Remove"
    end
  end
end
