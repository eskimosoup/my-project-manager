require "rails_helper"

feature "set project status" do
  scenario "from archived to quoted" do
    user = create(:user)
    project = create(:archived_project)

    visit project_path(project, as: user)
    click_button "Mark As Quoted"

    expect(page).to have_content("Quoted")
  end

  scenario "from quoted to sold" do
    user = create(:user)
    project = create(:quoted_project)

    visit project_path(project, as: user)
    click_button "Mark As Sold"

    expect(page).to have_content("Sold")
  end

  scenario "from quoted to archived" do
    user = create(:user)
    project = create(:quoted_project)

    visit project_path(project, as: user)
    click_button "Archive Project"

    expect(page).to have_content "Archived"
  end

  scenario "from sold to finalised" do
    user = create(:user)
    project = create(:sold_project, name: "Project x")

    visit project_path(project, as: user)
    click_link "Finalise Project"
    fill_in "status_changer_finalised_name", with: "Project y"
    click_button "Finalise"

    expect(page).to have_css "h1", text: "Project y"
  end

  scenario "from finalised to completed" do
    user = create(:user)
    project = create(:finalised_project)
    
    visit project_path(project, as: user)
    click_button "Complete Project"
    
    expect(page).to have_content("Completed")
  end

  scenario "from completed to finalised" do
    user = create(:user)
    project = create(:completed_project)

    visit project_path(project, as: user)
    click_button "Finalise Project"

    expect(page).to have_content("Finalised")
  end
end
