require "rails_helper"

describe "User manages account management", type: :feature do
  it "creates account management" do
    print_job = create(:print_job)

    visit print_job_path(print_job)
    click_on "Add Account Management"

    fill_form(:account_management, { hours: 5 })
    click_on "Create Account management"

    expect(page).to have_css ".account-management", text: "5.0 hours"
  end

  it "edits account management" do
    account_management = create(:account_management)

    visit print_job_path(account_management.print_job)
    edit_account_management(account_management)

    fill_in "Hours", with: 8.50
    click_on "Update Account management"

    expect(page).to have_css ".account-management", text: "8.5 hours"
  end

  it "removes account management" do
    account_management = create(:account_management)

    visit print_job_path(account_management.print_job)
    destroy_account_management(account_management)

    expect(page).not_to have_css "#account_management_#{ account_management.id }"
  end

  def edit_account_management(account_management)
    within("#account_management_#{ account_management.id }") do
      click_on "Edit"
    end
  end

  def destroy_account_management(account_management)
    within("#account_management_#{ account_management.id }") do
      click_on "Remove"
    end
  end
end
