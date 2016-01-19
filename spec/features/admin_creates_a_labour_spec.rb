require "rails_helper"

feature "Admin creates a labour", type: :feature do
  scenario "successfully" do
    user = create(:admin_user)

    visit admin_root_path(as: user)

    click_on "Labours"
    click_on "New labour"

    fill_form(:labour, { name: "Some name", description: "Labour desc", per_hour: 15.00,
                         mark_up: 200 })

    click_on "Create Labour"

    expect(page).to have_css ".attribute-data.attribute-data--string", text: "Some name"
  end
end

