require "rails_helper"

feature "User sets project addresses" do
  describe "Adding shipping address" do
    scenario "existing address", js: true do
      project = create(:project)
      address = create(:address, customer: project.customer)

      visit project_path(project)
      click_on "Set Shipping Address"
      set_shipping_address(address)
      click_on "Set Shipping Address"
      
      expect(page).to have_content address.line_1
    end
  end

  scenario "Changing shipping address" do
    customer = create(:customer)
    address = create(:address, customer: customer)
    project = create(:project, customer: customer, shipping_address: address)
    second_address = create(:address, customer: customer)

    visit project_path(project)
    within "#shipping-address-details" do
      click_on "Change"
    end
    within "#shipping-address-#{ second_address.id }" do
      click_on "Use"
    end
    click_on "Set Shipping Address"

    expect(page).to have_content second_address.line_1
  end

  describe "Adding billing address" do
    scenario "existing address" do
    end
  end

  def set_shipping_address(address)
    within "#shipping-address-#{ address.id }" do
      click_on "Use"
    end
  end
end
