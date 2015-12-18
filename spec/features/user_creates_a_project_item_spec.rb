require "rails_helper"

feature "User creates a project item spec" do
  scenario "successfully" do
    project = create(:project)
    product = create(:product)

    visit project_path(project)

    click_on "Add Product To Project"

    fill_form(:project_item, { size: 1.5, product_id: product.name })
    click_on "Create Project item"

    expect(page).to have_css ".project_item .product-name", text: product.name
  end
end
