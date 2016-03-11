require "rails_helper"

feature "User sets project addresses" do
  describe "Adding shipping address" do
    scenario "existing address", js: true do
      user = create(:user)
      project = create(:project)
      address = create(:address, customer: project.customer)

      visit project_path(project, as: user)
      click_on "Set Shipping Address"
      set_shipping_address(address)
      click_on "Set Shipping Address"
      
      expect(page).to have_content address.line_1
    end
  end

  scenario "Changing shipping address", js: true do
    user = create(:user)
    customer = create(:customer)
    address = create(:address, customer: customer)
    project = create(:project, customer: customer, shipping_address: address)
    second_address = create(:address, customer: customer)

    visit project_path(project, as: user)
    within "#shipping-address-details" do
      click_on "Edit"
    end
    within "#shipping-address-#{ second_address.id }" do
      click_on "Use"
    end
    click_on "Set Shipping Address"

    expect(page).to have_content second_address.line_1
  end

  describe "Adding billing address" do
    scenario "existing address", js: true do
      user = create(:user)
      project = create(:project)
      address = create(:address, customer: project.customer)

      visit project_path(project, as: user)
      click_on "Set Billing Address"
      set_billing_address(address)
      click_on "Set Billing Address"

      expect(page).to have_content address.line_1
    end
  end

  scenario "Changing billing address", js: true do
    user = create(:user)
    customer = create(:customer)
    address = create(:address, customer: customer)
    project = create(:project, customer: customer, billing_address: address)
    second_address = create(:address, customer: customer)

    visit project_path(project, as: user)
    within "#billing-address-details" do
      click_on "Edit"
    end
    within "#billing-address-#{ second_address.id }" do
      click_on "Use"
    end
    click_on "Set Billing Address"

    expect(page).to have_content second_address.line_1
  end

  def set_shipping_address(address)
    within "#shipping-address-#{ address.id }" do
      click_on "Use"
    end
  end

  def set_billing_address(address)
    within "#billing-address-#{ address.id }" do
      click_on "Use"
    end
  end
end
