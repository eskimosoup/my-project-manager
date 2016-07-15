require "rails_helper"

describe "User manages my service items" do
  scenario "add a my service item" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)

    visit print_job_path(print_job, as: user)
    click_on "Add My Service Item"

    fill_form(:my_service_item, { name: "Blah", cost: 5.00 })
    click_on "Create My service item"

    expect(page).to have_css ".basic-listing-details", text: "Blah"
  end

  scenario "editing" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)
    my_service_item = create(:my_service_item, name: "Old name", print_job: print_job)

    visit print_job_path(print_job, as: user)
    edit_my_service_item(my_service_item)

    fill_form(:my_service_item, { name: "Blah" })
    click_on "Update My service item"

    expect(page).to have_css ".basic-listing-details", text: "Blah"
  end

  scenario "destroying" do
    user = create(:user)
    brand = create(:my_print_services_brand)
    project = create(:project, brand: brand)
    print_job = create(:print_job, project: project)
    my_service_item = create(:my_service_item, name: "name", print_job: print_job)

    visit print_job_path(print_job, as: user)
    destroy_my_service_item(my_service_item)

    expect(page).not_to have_css ".basic-listing-details", text: "name"
  end

  def edit_my_service_item(my_service_item)
    within "#my_service_item_#{ my_service_item.id }" do
      click_link_by_href edit_my_service_item_path(my_service_item)
    end
  end

  def destroy_my_service_item(my_service_item)
    within "#my_service_item_#{ my_service_item.id}" do
      click_on "Remove"
    end
  end
end
