require "rails_helper"

describe "User manages a print job's product items", type: :feature do
  scenario "adds a product item" do
    user = create(:user)
    print_job = create(:print_job)
    product = create(:product)
    
    visit print_job_path(print_job, as: user)
    click_on "Add Material"

    fill_form(:product_item, { area: 5, product_id: product.name })
    click_on "Create Product item"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".product-item-link", text: product.name
  end

  scenario "edits a product item" do
    user = create(:user)
    product_item = create(:product_item)

    visit print_job_path(product_item.print_job, as: user)
    edit_product_item(product_item)

    fill_in "Area", with: 8
    click_on "Update Product item"

    expect(page).to have_css ".product-item-link", text: "8.0m"
  end

  scenario "removes a product item", js: true do
    user = create(:user)
    product_item = create(:product_item)
    visit print_job_path(product_item.print_job, as: user)

    destroy_product_item(product_item)

    expect(page).not_to have_css "#product_item_#{ product_item.id }"
  end

  def edit_product_item(product_item)
    within "#product_item_#{ product_item.id }" do
      click_link_by_href(edit_product_item_path(product_item))
    end
  end

  def destroy_product_item(product_item)
    within "#product_item_#{ product_item.id }" do
      click_on "Remove"
    end
  end
end
