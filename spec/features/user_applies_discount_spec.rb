require 'rails_helper'

feature "User manages discounts on a project", type: :feature do
  it "creating a discount" do
    user = create(:user)
    project = create(:project)
    print_job = create(:print_job, project: project)
    product = create(:product)
    product_item = create(:product_item, print_job: print_job, product: product)

    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    click_on "Apply Discount"
    fill_in "discount_description", with: "A Discount"
    fill_in "discount_percentage", with: 10
    click_on "Submit"

    expect(page).to have_css ".discount-description", text: "A Discount"
  end

  it "editing a discount" do
    user = create(:user)
    project = create(:project)
    print_job = create(:print_job, project: project)
    product = create(:product)
    product_item = create(:product_item, print_job: print_job, product: product)
    discount = create(:discount, project: project)

    sign_in_with(user.email, user.password)
    go_to_project_page(project)
    within "#discount_#{ discount.id }" do
      click_on "Edit"
    end
    fill_in "discount_description", with: "A Discount"
    fill_in "discount_percentage", with: 15
    click_on "Submit"

    expect(page).to have_css ".discount-description", text: "A Discount"
  end
end
