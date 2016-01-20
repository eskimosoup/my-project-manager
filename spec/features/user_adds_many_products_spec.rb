require "rails_helper"

feature "User adds many products" do
  scenario "successfully" do
    user = create(:user)
    print_job = create(:print_job)
    product1 = create(:product)
    product2 = create(:product)

    visit print_job_path(print_job, as: user)
    click_on "Add Multiple Products"
    fill_form(:multiple_product_addition, { "#{ product1.name } Area" => 12,
    "#{ product2.name } Area" => 5 })
    click_on "Add Products"

    expect(page).to have_css ".product-item-link", text: product1.name
    expect(page).to have_css ".product-item-link", text: product2.name
  end
end
