require 'rails_helper'
RSpec.describe MyPrintServicesItemPresenter, type: :presenter do
  let(:my_print_services_item) { build_stubbed(:my_print_services_item) }
  subject(:my_print_services_item_presenter) { MyPrintServicesItemPresenter.new(object: my_print_services_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:my_print_services_item) }
    it { should delegate_method(:cost).to(:my_print_services_item) }
    it { should delegate_method(:quoted?).to(:my_print_services_item) }
  end

  describe 'standard my_print_services_item' do
    it 'returns the my_print_services_item text' do
      expect(my_print_services_item_presenter.cost_currency).to eq(number_to_currency my_print_services_item.cost)
    end

    it '#edit_path' do
      expect(my_print_services_item_presenter.edit_path).to eq(edit_my_print_services_item_path(my_print_services_item))
    end

    it 'returns the edit link' do
      expect(my_print_services_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_my_print_services_item_path(my_print_services_item))
    end

    it 'returns the edit link with custom text' do
      expect(my_print_services_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_my_print_services_item_path(my_print_services_item))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(my_print_services_item).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ my_print_services_item.name } #{ number_to_currency(my_print_services_item.cost) }".html_safe, edit_my_print_services_item_path(my_print_services_item), class: 'basic-listing-link'

      expect(my_print_services_item_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(my_print_services_item).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', my_print_services_item_path(my_print_services_item), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(my_print_services_item_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(my_print_services_item).to receive(:quoted?).and_return(false)

      expect(my_print_services_item_presenter.octicon_edit_link).to eq("#{ my_print_services_item.name } #{ number_to_currency(my_print_services_item.cost) }")
    end

    it "#delete_link" do
      allow(my_print_services_item).to receive(:quoted?).and_return(false)

      expect(my_print_services_item_presenter.delete_link).to eq(nil)
    end
  end
end
