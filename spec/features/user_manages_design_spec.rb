require "rails_helper"

describe "User manages design", type: :feature do
  it "creates design" do
    project = create(:project)

    visit project_path(project)
    click_on "Add Design"

    fill_form(:design, { hours: 5 })
    click_on "Create Design"

    expect(page).to have_css ".design", text: "5.0 hours"
  end

  it "edits design" do
    design = create(:design)

    visit project_path(design.project)
    edit_design(design)

    fill_in "Hours", with: 3
    click_on "Update Design"

    expect(page).to have_css ".design", text: "3.0 hours"
  end

  it "removes design" do
    design = create(:design)

    visit project_path(design.project)
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
