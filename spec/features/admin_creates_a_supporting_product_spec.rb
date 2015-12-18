require "rails_helper"

feature "Admin creates a supporting product", type: :feature do
  scenario "successfully" do
    user = create(:admin_user)

    visit admin_root_path(as: user)

    click_on "Supporting Products"
    click_on "New supporting product"

    fill_form(:supporting_product, { name: "Supporting product name", description: "A description",
                                     substrate_cost: 10.50, mark_up: 120 })

    click_on "Create Supporting product"

    expect(page).to have_css ".attribute-data.attribute-data--string", text: "Supporting product name"
  end
end
