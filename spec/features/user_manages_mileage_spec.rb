require "rails_helper"

describe "User manages mileage", type: :feature do
  scenario "adds mileage" do
    user = create(:user)
    print_job = create(:print_job)

    visit print_job_path(print_job, as: user)
    click_on "Add Mileage"

    fill_form(:mileage, { miles: 10 })
    click_on "Create Mileage"

    expect(current_path).to eq(print_job_path(print_job))
    expect(page).to have_css ".mileage", text: "10.0 miles"
  end

  scenario "edit mileage" do
    user = create(:user)
    mileage = create(:mileage)

    visit print_job_path(mileage.print_job, as: user)
    edit_mileage(mileage)

    fill_in "Miles", with: 3.0
    click_on "Update Mileage"

    expect(page).to have_css ".mileage", text: "3.0 miles"
  end

  scenario "remove mileage" do
    user = create(:user)
    mileage = create(:mileage)

    visit print_job_path(mileage.print_job, as: user)
    destroy_mileage(mileage)

    expect(page).not_to have_css ".mileage", text: mileage.miles
  end

  def edit_mileage(mileage)
    within "#mileage_#{ mileage.id }" do
      click_on "Edit"
    end
  end

  def destroy_mileage(mileage)
    within "#mileage_#{ mileage.id }" do
      click_on "Remove"
    end
  end
end
