require 'rails_helper'

RSpec.feature "Admin creates a product", type: :feature do
  scenario "successfully" do
    user = create(:admin_user)

    visit admin_root_path(as: user)
    click_on "Products"
    click_on "New product"

    fill_form(:product, { name: "Product name", description: "Some description", substrate_cost: 13.47, mark_up: 300 })

    click_on "Create Product"

    expect(page).to have_css ".attribute-data.attribute-data--string", text: "Product name"
  end
end
