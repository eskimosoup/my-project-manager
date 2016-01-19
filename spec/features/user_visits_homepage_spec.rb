require "rails_helper"

feature "User visits homepage", type: :feature do
  scenario "successfully" do
    visit root_path

    expect(page).to have_css "h1", text: "My Project Manager"
  end
end
