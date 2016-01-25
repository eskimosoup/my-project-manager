require "rails_helper"

feature "set project status" do
  scenario "from quoted to sold" do
    user = create(:user)
    project = create(:quoted_project)

    visit project_path(project, as: user)
    click_on "Mark As Sold"

    expect(page).to have_content("Sold")
  end
end
