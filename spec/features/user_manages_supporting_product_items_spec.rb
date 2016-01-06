require "rails_helper"

describe "User manages a print job's supporting product items", type: :feature do
  scenario "adds a supporting product item" do
    print_job = create(:print_job)
    supporting_product = create(:supporting_product)

    visit print_job_path(print_job)
    click_on "Add Supporting Product"

    fill_form(:supporting_product_item, { area: 5, supporting_product_id: supporting_product.name })
    click_on "Create Supporting product item"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".supporting-product-item", text: supporting_product.name
  end

  scenario "edits a supporting product item" do
    supporting_product_item = create(:supporting_product_item)

    visit print_job_path(supporting_product_item.print_job)
    edit_supporting_product_item(supporting_product_item)

    fill_in "Area", with: 5
    click_on "Update Supporting product item"

    expect(page).to have_css ".supporting-product-item", text: "5.0m"
  end
  
  scenario "removes a supporting product item" do
    supporting_product_item = create(:supporting_product_item)

    visit print_job_path(supporting_product_item.print_job)
    destroy_supporting_product_item(supporting_product_item)

    expect(page).not_to have_css "#supporting_product_item_#{ supporting_product_item.id }"
  end

  def edit_supporting_product_item(supporting_product_item)
    within "#supporting_product_item_#{ supporting_product_item.id }" do
      click_on "Edit"
    end
  end

  def destroy_supporting_product_item(supporting_product_item)
    within "#supporting_product_item_#{ supporting_product_item.id }" do
      click_on "Remove"
    end
  end

end
