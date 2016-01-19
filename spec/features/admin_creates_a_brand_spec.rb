require "rails_helper"

feature "Admin creates a brand", type: :feature do
  scenario "successfully" do
    user = create(:admin_user)

    visit admin_root_path(as: user)

    click_on "Brands"
    click_on "New brand"

    fill_form(:brand, { name: "My new brand" })

    click_on "Create Brand"

    expect(page).to have_css ".attribute-data.attribute-data--string", text: "My new brand"
  end
end
