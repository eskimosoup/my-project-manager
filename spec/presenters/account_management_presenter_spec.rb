require 'rails_helper'
#  rspec --tag 'account_management_presenter'
RSpec.describe AccountManagementPresenter, type: :presenter, account_management_presenter: true do
  let(:account_management) { build(:account_management) }
  subject(:account_management_presenter) { AccountManagementPresenter.new(object: account_management, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:account_management) }
    it { should delegate_method(:quoted?).to(:account_management) }
  end

  describe 'standard account_management' do
    it 'returns the time' do
      expect(account_management_presenter.time).to eq(pluralize(account_management.hours, "hour"))
    end

    it '#edit_path' do
      expect(account_management_presenter.edit_path).to eq(edit_account_management_path(account_management))
    end

    it 'returns the edit link' do
      expect(account_management_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_account_management_path(account_management))
    end

    it 'returns the edit link with custom text' do
      expect(account_management_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_account_management_path(account_management))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(account_management).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ pluralize(account_management.hours, "hour") }".html_safe, 
        edit_account_management_path(account_management), class: 'basic-listing-link'

      expect(account_management_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(account_management).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', account_management_path(account_management), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(account_management_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(account_management).to receive(:quoted?).and_return(false)

      expect(account_management_presenter.octicon_edit_link).to eq(pluralize(account_management.hours, "hour"))
    end

    it "#delete_link" do
      allow(account_management).to receive(:quoted?).and_return(false)

      expect(account_management_presenter.delete_link).to eq(nil)
    end
  end
end
