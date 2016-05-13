require "rails_helper"

feature "User views the monthly report overview" do
  scenario "visiting may 2016" do
    user = create(:user)
    project = create(:finalised_project, name: "Right project", finalised_at: Date.new(2016, 5, 1))
    wrong_month = create(:finalised_project, name: "Wrong project", finalised_at: Date.new(2016,4,1))

    visit financial_reports_monthly_overview_path(year: 2016, month: 5, as: user)

    expect(page).to have_content("Right project")
    expect(page).not_to have_content("Wrong project")
  end
end
