require "rails_helper"

describe "User manages my print services items" do
  scenario "add a my print services item" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)

    visit print_job_path(print_job, as: user)
    click_on "Add My Print Service Item"

    fill_form(:my_print_services_item, { name: "Blah", cost: 5.00 })
    click_on "Create My print services item"

    expect(page).to have_css ".basic-listing-details", text: "Blah"
  end

  scenario "editing" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)
    my_print_services_item = create(:my_print_services_item, name: "Old name", print_job: print_job)

    visit print_job_path(print_job, as: user)
    edit_my_print_services_item(my_print_services_item)

    fill_form(:my_print_services_item, { name: "Blah" })
    click_on "Update My print services item"

    expect(page).to have_css ".basic-listing-details", text: "Blah"
  end

  scenario "destroying" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)
    my_print_services_item = create(:my_print_services_item, name: "name", print_job: print_job)

    visit print_job_path(print_job, as: user)
    destroy_my_print_services_item(my_print_services_item)

    expect(page).not_to have_css ".basic-listing-details", text: "name"
  end

  def edit_my_print_services_item(my_print_services_item)
    within "#my_print_services_item_#{ my_print_services_item.id }" do
      click_link_by_href edit_my_print_services_item_path(my_print_services_item)
    end
  end

  def destroy_my_print_services_item(my_print_services_item)
    within "#my_print_services_item_#{ my_print_services_item.id}" do
      click_on "Remove"
    end
  end
end
