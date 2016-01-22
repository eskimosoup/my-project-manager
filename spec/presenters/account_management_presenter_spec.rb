require 'rails_helper'
#  rspec --tag 'account_management_presenter'
RSpec.describe AccountManagementPresenter, type: :presenter, account_management_presenter: true do
  let(:account_management) { build(:account_management) }
  subject(:account_management_presenter) { AccountManagementPresenter.new(object: account_management, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:account_management) }
  end

  describe 'standard account_management' do
    it 'returns the time' do
      expect(account_management_presenter.time).to eq(pluralize(account_management.hours, "hour"))
    end

    it 'returns the link' do
      expect(account_management_presenter.edit_link).to eq(edit_account_management_path(account_management))
    end

    it 'returns the edit link' do
      expect(account_management_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_account_management_path(account_management))
    end

    it 'returns the edit link with custom text' do
      expect(account_management_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_account_management_path(account_management))
    end
  end
end
