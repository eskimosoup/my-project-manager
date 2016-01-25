require "rails_helper"

describe "User manages account management", type: :feature do
  it "creates account management" do
    user = create(:user)
    print_job = create(:print_job)

    visit print_job_path(print_job, as: user)
    click_on "Add Account Management"

    fill_form(:account_management, { hours: 5 })
    click_on "Create Account management"

    expect(page).to have_css ".basic-listing-details", text: "5.0 hours"
  end

  it "edits account management" do
    user = create(:user)
    account_management = create(:account_management)

    visit print_job_path(account_management.print_job, as: user)
    edit_account_management(account_management)

    fill_in "Hours", with: 8.50
    click_on "Update Account management"

    expect(page).to have_css ".basic-listing-details", text: "8.5 hours"
  end

  it "removes account management" do
    user = create(:user)
    account_management = create(:account_management)

    visit print_job_path(account_management.print_job, as: user)
    destroy_account_management(account_management)

    expect(page).not_to have_css ".basic-listing-details", 
      text: "#{ account_management.hours } hours"
  end

  def edit_account_management(account_management)
    within("#account_management_#{ account_management.id }") do
      click_link_by_href edit_account_management_path(account_management)
    end
  end

  def destroy_account_management(account_management)
    within("#account_management_#{ account_management.id }") do
      click_on "Remove"
    end
  end
end
