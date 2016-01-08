require "rails_helper"

describe "User manages account management", type: :feature do
  it "creates account management" do
    project = create(:project)

    visit project_path(project)
    click_on "Add Account Management"

    fill_form(:account_management, { hours: 5 })
    click_on "Create Account management"

    expect(page).to have_css ".account-management", text: "5.0 hours"
  end

  it "edits account management" do
    account_management = create(:account_management)

    visit project_path(account_management.project)
    edit_account_management(account_management)

    fill_in "Hours", with: 8.50
    click_on "Update Account management"

    expect(page).to have_css ".account-management", text: "8.5 hours"
  end

  it "removes account management" do
    account_management = create(:account_management)

    visit project_path(account_management.project)
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
