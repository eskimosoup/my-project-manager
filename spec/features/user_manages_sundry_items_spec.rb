require "rails_helper"

describe "User manages a print job's sundry items" do
  scenario "add a sundry item" do
    print_job = create(:print_job)

    visit print_job_path(print_job)
    click_on "Add Sundry Item"

    fill_form(:sundry_item, { name: "Acryllic", cost: 5.00 })
    click_on "Create Sundry item"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".sundry-item", text: "Acryllic"
  end

  scenario "edit sundry item" do
    sundry_item = create(:sundry_item)

    visit print_job_path(sundry_item.print_job)
    edit_sundry_item(sundry_item)

    fill_in "Name", with: "New name"
    click_on "Update Sundry item"

    expect(page).to have_css ".sundry-item", text: "New name"
  end

  scenario "remove sundry item" do
    sundry_item = create(:sundry_item)

    visit print_job_path(sundry_item.print_job)
    destroy_sundry_item(sundry_item)

    expect(page).not_to have_css ".sundry-item", text: sundry_item.name
  end

  def edit_sundry_item(sundry_item)
    within "#sundry_item_#{ sundry_item.id }" do
      click_on "Edit"
    end
  end

  def destroy_sundry_item(sundry_item)
    within "#sundry_item_#{ sundry_item.id}" do
      click_on "Remove"
    end
  end
end
