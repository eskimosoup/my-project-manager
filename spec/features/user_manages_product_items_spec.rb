require "rails_helper"

describe "User manages a print job's product items", type: :feature do
  scenario "adds a product item" do
    print_job = create(:print_job)
    product = create(:product)
    
    visit print_job_path(print_job)
    click_on "Add Product"

    fill_form(:product_item, { area: 5, product_id: product.name })
    click_on "Create Product item"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".product-item", text: product.name
  end

  scenario "edits a product item" do
    product_item = create(:product_item)

    visit print_job_path(product_item.print_job)
    edit_product_item(product_item)

    fill_in "Area", with: 8
    click_on "Update Product item"

    expect(page).to have_css ".product-item", text: "8.0m"
  end

  scenario "removes a product item", js: true do
    product_item = create(:product_item)
    visit print_job_path(product_item.print_job)

    destroy_product_item(product_item)

    expect(page).not_to have_css "#product_item_#{ product_item.id }"
  end

  def edit_product_item(product_item)
    within "#product_item_#{ product_item.id }" do
      click_on "Edit"
    end
  end

  def destroy_product_item(product_item)
    within "#product_item_#{ product_item.id }" do
      click_on "Remove"
    end
  end
end
